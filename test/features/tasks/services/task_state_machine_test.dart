// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter_test/flutter_test.dart';
import 'package:socialmesh/core/auth/permission_service.dart';
import 'package:socialmesh/core/auth/role.dart';
import 'package:socialmesh/features/tasks/models/task.dart';
import 'package:socialmesh/features/tasks/services/task_database.dart';
import 'package:socialmesh/features/tasks/services/task_state_machine.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

PermissionService _service(Role role) =>
    PermissionService(role: role, orgId: 'org-1');

Task _task({
  String id = 'task-1',
  TaskState state = TaskState.assigned,
  String assigneeId = 'uid-assignee',
  String createdBy = 'uid-supervisor',
}) => Task(
  id: id,
  orgId: 'org-1',
  title: 'Test task',
  state: state,
  priority: TaskPriority.immediate,
  createdBy: createdBy,
  assigneeId: assigneeId,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

/// Insert a bare task row into the database so the state machine
/// has something to update.
Future<void> _insertTask(TaskDatabase db, Task task) async {
  await db.database.insert('tasks', task.toMap());
}

/// Read the current state projection from the tasks table.
Future<String> _readState(TaskDatabase db, String taskId) async {
  final rows = await db.database.query(
    'tasks',
    columns: ['state'],
    where: 'id = ?',
    whereArgs: [taskId],
  );
  return rows.first['state'] as String;
}

// ---------------------------------------------------------------------------
// Test suite
// ---------------------------------------------------------------------------

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late TaskDatabase db;

  setUp(() async {
    db = TaskDatabase(dbPathOverride: inMemoryDatabasePath);
    await db.open();
  });

  tearDown(() async {
    await db.close();
  });

  // =========================================================================
  // 1) Valid transitions (10)
  // =========================================================================

  group('valid transitions', () {
    test('1. created -> assigned (assign)', () async {
      final sm = TaskStateMachine(
        db: db,
        permissions: _service(Role.supervisor),
      );
      final task = _task(state: TaskState.created);
      await _insertTask(db, task);

      final t = await sm.transition(
        task: task,
        target: TaskState.assigned,
        actorId: 'uid-supervisor',
        actorRole: Role.supervisor,
      );
      expect(t.fromState, TaskState.created);
      expect(t.toState, TaskState.assigned);
      expect(await _readState(db, task.id), 'assigned');
    });

    test('2. assigned -> acknowledged (acknowledge)', () async {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.operator));
      final task = _task(state: TaskState.assigned);
      await _insertTask(db, task);

      final t = await sm.transition(
        task: task,
        target: TaskState.acknowledged,
        actorId: 'uid-assignee',
        actorRole: Role.operator,
      );
      expect(t.fromState, TaskState.assigned);
      expect(t.toState, TaskState.acknowledged);
      expect(await _readState(db, task.id), 'acknowledged');
    });

    test('3. acknowledged -> in_progress (startWork)', () async {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.operator));
      final task = _task(state: TaskState.acknowledged);
      await _insertTask(db, task);

      final t = await sm.transition(
        task: task,
        target: TaskState.inProgress,
        actorId: 'uid-assignee',
        actorRole: Role.operator,
      );
      expect(t.fromState, TaskState.acknowledged);
      expect(t.toState, TaskState.inProgress);
      expect(await _readState(db, task.id), 'in_progress');
    });

    test('4. in_progress -> completed (complete)', () async {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.operator));
      final task = _task(state: TaskState.inProgress);
      await _insertTask(db, task);

      final t = await sm.transition(
        task: task,
        target: TaskState.completed,
        actorId: 'uid-assignee',
        actorRole: Role.operator,
        completionNote: 'Valve sealed and pressure tested at 150psi',
      );
      expect(t.fromState, TaskState.inProgress);
      expect(t.toState, TaskState.completed);
      expect(await _readState(db, task.id), 'completed');
    });

    test('5. in_progress -> failed (fail)', () async {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.operator));
      final task = _task(state: TaskState.inProgress);
      await _insertTask(db, task);

      final t = await sm.transition(
        task: task,
        target: TaskState.failed,
        actorId: 'uid-assignee',
        actorRole: Role.operator,
        failureReason: 'Access road washed out, cannot reach site',
      );
      expect(t.fromState, TaskState.inProgress);
      expect(t.toState, TaskState.failed);
      expect(await _readState(db, task.id), 'failed');
    });

    test('6. failed -> reassigned (reassign)', () async {
      final sm = TaskStateMachine(
        db: db,
        permissions: _service(Role.supervisor),
      );
      final task = _task(state: TaskState.failed);
      await _insertTask(db, task);

      final t = await sm.transition(
        task: task,
        target: TaskState.reassigned,
        actorId: 'uid-supervisor',
        actorRole: Role.supervisor,
        newAssigneeId: 'uid-new-operator',
      );
      expect(t.fromState, TaskState.failed);
      expect(t.toState, TaskState.reassigned);
      expect(await _readState(db, task.id), 'reassigned');
    });

    test('7. created -> cancelled (cancel)', () async {
      final sm = TaskStateMachine(
        db: db,
        permissions: _service(Role.supervisor),
      );
      final task = _task(state: TaskState.created);
      await _insertTask(db, task);

      final t = await sm.transition(
        task: task,
        target: TaskState.cancelled,
        actorId: 'uid-supervisor',
        actorRole: Role.supervisor,
      );
      expect(t.toState, TaskState.cancelled);
      expect(await _readState(db, task.id), 'cancelled');
    });

    test('8. assigned -> cancelled (cancel)', () async {
      final sm = TaskStateMachine(
        db: db,
        permissions: _service(Role.supervisor),
      );
      final task = _task(state: TaskState.assigned);
      await _insertTask(db, task);

      final t = await sm.transition(
        task: task,
        target: TaskState.cancelled,
        actorId: 'uid-supervisor',
        actorRole: Role.supervisor,
      );
      expect(t.toState, TaskState.cancelled);
      expect(await _readState(db, task.id), 'cancelled');
    });

    test('9. acknowledged -> cancelled (cancel)', () async {
      final sm = TaskStateMachine(
        db: db,
        permissions: _service(Role.supervisor),
      );
      final task = _task(state: TaskState.acknowledged);
      await _insertTask(db, task);

      final t = await sm.transition(
        task: task,
        target: TaskState.cancelled,
        actorId: 'uid-supervisor',
        actorRole: Role.supervisor,
      );
      expect(t.toState, TaskState.cancelled);
      expect(await _readState(db, task.id), 'cancelled');
    });

    test('10. in_progress -> cancelled (cancel)', () async {
      final sm = TaskStateMachine(
        db: db,
        permissions: _service(Role.supervisor),
      );
      final task = _task(state: TaskState.inProgress);
      await _insertTask(db, task);

      final t = await sm.transition(
        task: task,
        target: TaskState.cancelled,
        actorId: 'uid-supervisor',
        actorRole: Role.supervisor,
      );
      expect(t.toState, TaskState.cancelled);
      expect(await _readState(db, task.id), 'cancelled');
    });
  });

  // =========================================================================
  // 2) Invalid transitions
  // =========================================================================

  group('invalid transitions', () {
    test('completed -> any (terminal state)', () async {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.admin));
      final task = _task(state: TaskState.completed);
      await _insertTask(db, task);

      expect(
        () => sm.transition(
          task: task,
          target: TaskState.assigned,
          actorId: 'uid-admin',
          actorRole: Role.admin,
        ),
        throwsA(isA<InvalidTransitionException>()),
      );
    });

    test('cancelled -> any (terminal state)', () async {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.admin));
      final task = _task(state: TaskState.cancelled);
      await _insertTask(db, task);

      expect(
        () => sm.transition(
          task: task,
          target: TaskState.assigned,
          actorId: 'uid-admin',
          actorRole: Role.admin,
        ),
        throwsA(isA<InvalidTransitionException>()),
      );
    });

    test('reassigned -> any (terminal state)', () async {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.admin));
      final task = _task(state: TaskState.reassigned);
      await _insertTask(db, task);

      expect(
        () => sm.transition(
          task: task,
          target: TaskState.assigned,
          actorId: 'uid-admin',
          actorRole: Role.admin,
        ),
        throwsA(isA<InvalidTransitionException>()),
      );
    });

    test('created -> acknowledged (must assign first)', () async {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.operator));
      final task = _task(state: TaskState.created);
      await _insertTask(db, task);

      expect(
        () => sm.transition(
          task: task,
          target: TaskState.acknowledged,
          actorId: 'uid-assignee',
          actorRole: Role.operator,
        ),
        throwsA(isA<InvalidTransitionException>()),
      );
    });

    test('assigned -> in_progress (must acknowledge first)', () async {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.operator));
      final task = _task(state: TaskState.assigned);
      await _insertTask(db, task);

      expect(
        () => sm.transition(
          task: task,
          target: TaskState.inProgress,
          actorId: 'uid-assignee',
          actorRole: Role.operator,
        ),
        throwsA(isA<InvalidTransitionException>()),
      );
    });

    test('acknowledged -> completed (must start work first)', () async {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.operator));
      final task = _task(state: TaskState.acknowledged);
      await _insertTask(db, task);

      expect(
        () => sm.transition(
          task: task,
          target: TaskState.completed,
          actorId: 'uid-assignee',
          actorRole: Role.operator,
          completionNote: 'This is a valid completion note',
        ),
        throwsA(isA<InvalidTransitionException>()),
      );
    });

    test('in_progress -> reassigned (must fail first)', () async {
      final sm = TaskStateMachine(
        db: db,
        permissions: _service(Role.supervisor),
      );
      final task = _task(state: TaskState.inProgress);
      await _insertTask(db, task);

      expect(
        () => sm.transition(
          task: task,
          target: TaskState.reassigned,
          actorId: 'uid-supervisor',
          actorRole: Role.supervisor,
          newAssigneeId: 'uid-new',
        ),
        throwsA(isA<InvalidTransitionException>()),
      );
    });

    test('failed -> completed (cannot complete failed)', () async {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.operator));
      final task = _task(state: TaskState.failed);
      await _insertTask(db, task);

      expect(
        () => sm.transition(
          task: task,
          target: TaskState.completed,
          actorId: 'uid-assignee',
          actorRole: Role.operator,
          completionNote: 'This is a valid note',
        ),
        throwsA(isA<InvalidTransitionException>()),
      );
    });
  });

  // =========================================================================
  // 3) Acknowledgement gate
  // =========================================================================

  group('acknowledgement gate', () {
    test('only assignee can acknowledge', () async {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.operator));
      final task = _task(state: TaskState.assigned);
      await _insertTask(db, task);

      // Non-assignee tries to acknowledge
      expect(
        () => sm.transition(
          task: task,
          target: TaskState.acknowledged,
          actorId: 'uid-wrong-person',
          actorRole: Role.operator,
        ),
        throwsA(isA<InsufficientPermissionException>()),
      );
    });

    test('supervisor cannot acknowledge on behalf of assignee', () async {
      final sm = TaskStateMachine(
        db: db,
        permissions: _service(Role.supervisor),
      );
      final task = _task(state: TaskState.assigned);
      await _insertTask(db, task);

      expect(
        () => sm.transition(
          task: task,
          target: TaskState.acknowledged,
          actorId: 'uid-supervisor',
          actorRole: Role.supervisor,
        ),
        throwsA(isA<InsufficientPermissionException>()),
      );
    });

    test('assignee can acknowledge successfully', () async {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.operator));
      final task = _task(state: TaskState.assigned);
      await _insertTask(db, task);

      final t = await sm.transition(
        task: task,
        target: TaskState.acknowledged,
        actorId: 'uid-assignee',
        actorRole: Role.operator,
      );
      expect(t.toState, TaskState.acknowledged);
    });
  });

  // =========================================================================
  // 4) Completion note length enforcement
  // =========================================================================

  group('completion note enforcement', () {
    test('completion with note < 10 chars is rejected', () async {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.operator));
      final task = _task(state: TaskState.inProgress);
      await _insertTask(db, task);

      expect(
        () => sm.transition(
          task: task,
          target: TaskState.completed,
          actorId: 'uid-assignee',
          actorRole: Role.operator,
          completionNote: 'short',
        ),
        throwsA(isA<InvalidTransitionException>()),
      );
    });

    test('completion with null note is rejected', () async {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.operator));
      final task = _task(state: TaskState.inProgress);
      await _insertTask(db, task);

      expect(
        () => sm.transition(
          task: task,
          target: TaskState.completed,
          actorId: 'uid-assignee',
          actorRole: Role.operator,
        ),
        throwsA(isA<InvalidTransitionException>()),
      );
    });

    test('completion with note >= 10 chars succeeds', () async {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.operator));
      final task = _task(state: TaskState.inProgress);
      await _insertTask(db, task);

      final t = await sm.transition(
        task: task,
        target: TaskState.completed,
        actorId: 'uid-assignee',
        actorRole: Role.operator,
        completionNote: 'Task completed successfully with full inspection',
      );
      expect(t.toState, TaskState.completed);
    });

    test('completion with exactly 10 chars succeeds', () async {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.operator));
      final task = _task(id: 'task-10', state: TaskState.inProgress);
      await _insertTask(db, task);

      final t = await sm.transition(
        task: task,
        target: TaskState.completed,
        actorId: 'uid-assignee',
        actorRole: Role.operator,
        completionNote: '1234567890',
      );
      expect(t.toState, TaskState.completed);
    });
  });

  // =========================================================================
  // 5) Failure reason length enforcement
  // =========================================================================

  group('failure reason enforcement', () {
    test('failure with reason < 10 chars is rejected', () async {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.operator));
      final task = _task(state: TaskState.inProgress);
      await _insertTask(db, task);

      expect(
        () => sm.transition(
          task: task,
          target: TaskState.failed,
          actorId: 'uid-assignee',
          actorRole: Role.operator,
          failureReason: 'too short',
        ),
        throwsA(isA<InvalidTransitionException>()),
      );
    });

    test('failure with null reason is rejected', () async {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.operator));
      final task = _task(state: TaskState.inProgress);
      await _insertTask(db, task);

      expect(
        () => sm.transition(
          task: task,
          target: TaskState.failed,
          actorId: 'uid-assignee',
          actorRole: Role.operator,
        ),
        throwsA(isA<InvalidTransitionException>()),
      );
    });

    test('failure with reason >= 10 chars succeeds', () async {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.operator));
      final task = _task(state: TaskState.inProgress);
      await _insertTask(db, task);

      final t = await sm.transition(
        task: task,
        target: TaskState.failed,
        actorId: 'uid-assignee',
        actorRole: Role.operator,
        failureReason: 'Equipment malfunction prevented completion',
      );
      expect(t.toState, TaskState.failed);
    });
  });

  // =========================================================================
  // 6) Reassignment linking
  // =========================================================================

  group('reassignment linking', () {
    test('reassignment creates new task and links both', () async {
      final sm = TaskStateMachine(
        db: db,
        permissions: _service(Role.supervisor),
      );
      final task = _task(state: TaskState.failed);
      await _insertTask(db, task);

      await sm.transition(
        task: task,
        target: TaskState.reassigned,
        actorId: 'uid-supervisor',
        actorRole: Role.supervisor,
        newAssigneeId: 'uid-new-operator',
      );

      // Original task is now reassigned with reassignedTo set.
      final originalRow = await db.database.query(
        'tasks',
        where: 'id = ?',
        whereArgs: [task.id],
      );
      expect(originalRow.first['state'], 'reassigned');
      final newTaskId = originalRow.first['reassignedTo'] as String;
      expect(newTaskId, isNotEmpty);

      // New task exists with correct state and link.
      final newRow = await db.database.query(
        'tasks',
        where: 'id = ?',
        whereArgs: [newTaskId],
      );
      expect(newRow, isNotEmpty);
      expect(newRow.first['state'], 'assigned');
      expect(newRow.first['assigneeId'], 'uid-new-operator');
      expect(newRow.first['reassignedFrom'], task.id);
      expect(newRow.first['title'], task.title);
      expect(newRow.first['orgId'], task.orgId);
      expect(newRow.first['priority'], task.priority.name);
    });

    test('reassignment without newAssigneeId is rejected', () async {
      final sm = TaskStateMachine(
        db: db,
        permissions: _service(Role.supervisor),
      );
      final task = _task(state: TaskState.failed);
      await _insertTask(db, task);

      expect(
        () => sm.transition(
          task: task,
          target: TaskState.reassigned,
          actorId: 'uid-supervisor',
          actorRole: Role.supervisor,
        ),
        throwsA(isA<InvalidTransitionException>()),
      );
    });

    test('reassignment records transitions for both tasks', () async {
      final sm = TaskStateMachine(
        db: db,
        permissions: _service(Role.supervisor),
      );
      final task = _task(state: TaskState.failed);
      await _insertTask(db, task);

      await sm.transition(
        task: task,
        target: TaskState.reassigned,
        actorId: 'uid-supervisor',
        actorRole: Role.supervisor,
        newAssigneeId: 'uid-new-operator',
      );

      // Original task should have a transition to reassigned.
      final originalTransitions = await db.database.query(
        'task_transitions',
        where: 'taskId = ?',
        whereArgs: [task.id],
      );
      expect(
        originalTransitions.any((r) => r['toState'] == 'reassigned'),
        isTrue,
      );

      // New task should have creation + assignment transitions.
      final originalRow = await db.database.query(
        'tasks',
        where: 'id = ?',
        whereArgs: [task.id],
      );
      final newTaskId = originalRow.first['reassignedTo'] as String;

      final newTransitions = await db.database.query(
        'task_transitions',
        where: 'taskId = ?',
        whereArgs: [newTaskId],
        orderBy: 'timestamp ASC, id ASC',
      );
      expect(newTransitions.length, 2);
      // Both transitions share the same timestamp so UUID-based ordering
      // is non-deterministic. Assert set membership instead of index order.
      final toStates = newTransitions
          .map((r) => r['toState'] as String)
          .toSet();
      expect(toStates, containsAll(<String>['created', 'assigned']));
    });
  });

  // =========================================================================
  // 7) Role validation
  // =========================================================================

  group('role validation', () {
    test('operator cannot create task', () async {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.operator));

      expect(
        () => sm.createTask(
          orgId: 'org-1',
          title: 'Test task',
          priority: TaskPriority.routine,
          assigneeId: 'uid-assignee',
          actorId: 'uid-operator',
        ),
        throwsA(isA<InsufficientPermissionException>()),
      );
    });

    test('observer cannot create task', () async {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.observer));

      expect(
        () => sm.createTask(
          orgId: 'org-1',
          title: 'Test task',
          priority: TaskPriority.routine,
          assigneeId: 'uid-assignee',
          actorId: 'uid-observer',
        ),
        throwsA(isA<InsufficientPermissionException>()),
      );
    });

    test('supervisor can create task', () async {
      final sm = TaskStateMachine(
        db: db,
        permissions: _service(Role.supervisor),
      );

      final task = await sm.createTask(
        orgId: 'org-1',
        title: 'Test task',
        priority: TaskPriority.routine,
        assigneeId: 'uid-assignee',
        actorId: 'uid-supervisor',
      );
      expect(task.state, TaskState.assigned);
      expect(task.assigneeId, 'uid-assignee');
    });

    test('admin can create task', () async {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.admin));

      final task = await sm.createTask(
        orgId: 'org-1',
        title: 'Test task',
        priority: TaskPriority.routine,
        assigneeId: 'uid-assignee',
        actorId: 'uid-admin',
      );
      expect(task.state, TaskState.assigned);
    });

    test('operator cannot cancel task', () async {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.operator));
      final task = _task(state: TaskState.assigned);
      await _insertTask(db, task);

      expect(
        () => sm.transition(
          task: task,
          target: TaskState.cancelled,
          actorId: 'uid-operator',
          actorRole: Role.operator,
        ),
        throwsA(isA<InsufficientPermissionException>()),
      );
    });

    test('operator cannot reassign task', () async {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.operator));
      final task = _task(state: TaskState.failed);
      await _insertTask(db, task);

      expect(
        () => sm.transition(
          task: task,
          target: TaskState.reassigned,
          actorId: 'uid-operator',
          actorRole: Role.operator,
          newAssigneeId: 'uid-new',
        ),
        throwsA(isA<InsufficientPermissionException>()),
      );
    });
  });

  // =========================================================================
  // 8) Full lifecycle: create -> acknowledge -> complete
  // =========================================================================

  group('full lifecycle', () {
    test('create -> acknowledge -> start -> complete', () async {
      final supervisorSm = TaskStateMachine(
        db: db,
        permissions: _service(Role.supervisor),
      );
      final operatorSm = TaskStateMachine(
        db: db,
        permissions: _service(Role.operator),
      );

      // Supervisor creates task.
      final task = await supervisorSm.createTask(
        orgId: 'org-1',
        title: 'Inspect valve',
        priority: TaskPriority.immediate,
        assigneeId: 'uid-operator',
        actorId: 'uid-supervisor',
      );
      expect(task.state, TaskState.assigned);

      // Operator acknowledges.
      final ackTransition = await operatorSm.transition(
        task: task,
        target: TaskState.acknowledged,
        actorId: 'uid-operator',
        actorRole: Role.operator,
      );
      expect(ackTransition.toState, TaskState.acknowledged);

      // Operator starts work.
      final ackedTask = task.copyWith(state: TaskState.acknowledged);
      final startTransition = await operatorSm.transition(
        task: ackedTask,
        target: TaskState.inProgress,
        actorId: 'uid-operator',
        actorRole: Role.operator,
      );
      expect(startTransition.toState, TaskState.inProgress);

      // Operator completes with note >= 10.
      final inProgressTask = task.copyWith(state: TaskState.inProgress);
      final completeTransition = await operatorSm.transition(
        task: inProgressTask,
        target: TaskState.completed,
        actorId: 'uid-operator',
        actorRole: Role.operator,
        completionNote: 'Valve sealed and pressure tested at 150psi',
      );
      expect(completeTransition.toState, TaskState.completed);
      expect(await _readState(db, task.id), 'completed');

      // Verify completion note was stored.
      final finalTask = await db.getTaskById(task.id);
      expect(finalTask, isNotNull);
      expect(
        finalTask!.completionNote,
        'Valve sealed and pressure tested at 150psi',
      );
    });

    test('attempt completion with note < 10 is rejected', () async {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.operator));
      final task = _task(state: TaskState.inProgress);
      await _insertTask(db, task);

      expect(
        () => sm.transition(
          task: task,
          target: TaskState.completed,
          actorId: 'uid-assignee',
          actorRole: Role.operator,
          completionNote: 'done',
        ),
        throwsA(
          isA<InvalidTransitionException>().having(
            (e) => e.message,
            'message',
            contains('at least 10 characters'),
          ),
        ),
      );
    });
  });

  // =========================================================================
  // 9) Task creation records transitions
  // =========================================================================

  group('task creation', () {
    test('createTask inserts task + two transitions', () async {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.admin));

      final task = await sm.createTask(
        orgId: 'org-1',
        title: 'Deploy sensor',
        priority: TaskPriority.priority,
        assigneeId: 'uid-assignee',
        actorId: 'uid-admin',
      );

      // Task row exists.
      final row = await db.getTaskById(task.id);
      expect(row, isNotNull);
      expect(row!.state, TaskState.assigned);

      // Two transitions: created -> created, created -> assigned.
      // Both share the same timestamp, so UUID-based ordering is
      // non-deterministic. Assert set membership instead.
      final transitions = await db.getTransitionsByTaskId(task.id);
      expect(transitions.length, 2);
      // Both originate from created state.
      expect(
        transitions.every((t) => t.fromState == TaskState.created),
        isTrue,
      );
      final toStates = transitions.map((t) => t.toState).toSet();
      expect(
        toStates,
        containsAll(<TaskState>[TaskState.created, TaskState.assigned]),
      );
    });
  });

  // =========================================================================
  // 10) canTransition / validTargets helpers
  // =========================================================================

  group('canTransition and validTargets', () {
    test('canTransition returns true for valid transitions', () {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.admin));
      expect(sm.canTransition(TaskState.created, TaskState.assigned), isTrue);
      expect(
        sm.canTransition(TaskState.assigned, TaskState.acknowledged),
        isTrue,
      );
      expect(
        sm.canTransition(TaskState.inProgress, TaskState.completed),
        isTrue,
      );
    });

    test('canTransition returns false for invalid transitions', () {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.admin));
      expect(sm.canTransition(TaskState.created, TaskState.completed), isFalse);
      expect(
        sm.canTransition(TaskState.assigned, TaskState.inProgress),
        isFalse,
      );
      expect(
        sm.canTransition(TaskState.completed, TaskState.assigned),
        isFalse,
      );
    });

    test('validTargets returns correct sets', () {
      final sm = TaskStateMachine(db: db, permissions: _service(Role.admin));
      expect(sm.validTargets(TaskState.created), {
        TaskState.assigned,
        TaskState.cancelled,
      });
      expect(sm.validTargets(TaskState.inProgress), {
        TaskState.completed,
        TaskState.failed,
        TaskState.cancelled,
      });
      expect(sm.validTargets(TaskState.completed), isEmpty);
      expect(sm.validTargets(TaskState.cancelled), isEmpty);
      expect(sm.validTargets(TaskState.reassigned), isEmpty);
    });
  });
}
