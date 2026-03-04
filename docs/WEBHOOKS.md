# Webhook Integration

SocialMesh поддерживает два режима отправки webhook-уведомлений о событиях mesh-сети.

## Режимы работы

### IFTTT (по умолчанию)
Запросы отправляются на `https://maker.ifttt.com/trigger/{eventName}/with/key/{webhookKey}`.
Тело запроса — JSON с полями `value1`, `value2`, `value3` (стандартный формат IFTTT Webhooks).

### Custom URL
Запросы отправляются на произвольный URL, заданный пользователем.
Тело запроса — JSON с полями:

| Поле | Тип | Описание |
|------|-----|----------|
| `event` | string | Название события (см. таблицу ниже) |
| `value1` | string? | Первое значение (зависит от события) |
| `value2` | string? | Второе значение |
| `value3` | string? | Третье значение |

Метод запроса: `POST`
Content-Type: `application/json`
Успешный ответ: любой HTTP 2xx статус.

---

## События и их payload

| Событие | `value1` | `value2` | `value3` |
|---------|----------|----------|----------|
| `meshtastic_message` | Имя отправителя | Текст сообщения | Название канала |
| `meshtastic_node_online` | Имя узла | ID узла (hex, напр. `!a1b2c3d4`) | ISO 8601 timestamp |
| `meshtastic_node_offline` | Имя узла | ID узла (hex) | ISO 8601 timestamp |
| `meshtastic_position` | Имя узла | `lat,lon` | Расстояние от центра геозоны или timestamp |
| `meshtastic_battery_low` | Имя узла | Уровень батареи (напр. `15%`) | Порог (напр. `Threshold: 20%`) |
| `meshtastic_temperature` | Имя узла | Температура (напр. `42.5°C`) | Порог (напр. `Threshold: 40.0°C`) |
| `meshtastic_sos` | Имя узла | ID узла (hex) | Координаты `lat,lon` или `Unknown location` |
| *custom* | Любое | Любое | Любое |

---

## Реализация обработчика

### Node.js / Express

```js
const express = require('express');
const app = express();
app.use(express.json());

app.post('/webhook', (req, res) => {
  const { event, value1, value2, value3 } = req.body;
  console.log(`Event: ${event}`, { value1, value2, value3 });

  switch (event) {
    case 'meshtastic_message':
      // value1 = sender, value2 = text, value3 = channel
      console.log(`Message from ${value1} in ${value3}: ${value2}`);
      break;
    case 'meshtastic_node_online':
    case 'meshtastic_node_offline':
      // value1 = node name, value2 = hex id, value3 = timestamp
      console.log(`Node ${value1} (${value2}) is now ${event.split('_').pop()}`);
      break;
    case 'meshtastic_battery_low':
      // value1 = node name, value2 = battery%, value3 = threshold
      console.log(`Low battery on ${value1}: ${value2} (${value3})`);
      break;
    case 'meshtastic_sos':
      // value1 = node name, value2 = hex id, value3 = coordinates
      console.log(`SOS from ${value1} at ${value3}`);
      break;
  }

  res.status(200).json({ ok: true });
});

app.listen(3000);
```

### Python / FastAPI

```python
from fastapi import FastAPI, Request

app = FastAPI()

@app.post("/webhook")
async def handle_webhook(request: Request):
    data = await request.json()
    event = data.get("event")
    value1 = data.get("value1")
    value2 = data.get("value2")
    value3 = data.get("value3")

    match event:
        case "meshtastic_message":
            print(f"Message from {value1} in {value3}: {value2}")
        case "meshtastic_node_online" | "meshtastic_node_offline":
            status = "online" if "online" in event else "offline"
            print(f"Node {value1} ({value2}) is {status}")
        case "meshtastic_battery_low":
            print(f"Low battery on {value1}: {value2}")
        case "meshtastic_sos":
            print(f"SOS from {value1} at {value3}")

    return {"ok": True}
```

### Make (ex-Integromat) / n8n / Zapier

Используй webhook-триггер с URL от платформы. SocialMesh отправит POST-запрос с JSON-телом.
Для извлечения полей используй маппинг: `{{body.event}}`, `{{body.value1}}` и т.д.

---

## Безопасность

- Используй HTTPS для webhook URL.
- Добавь секретный токен в URL как query-параметр (`?token=xxx`) и проверяй его в обработчике.
- Настрой allowlist IP-адресов, если инфраструктура позволяет.
- Не логируй `value2` для событий `meshtastic_message` — это может содержать приватные сообщения.

---

## Конфигурация в приложении

1. Настройки → IFTTT / Webhooks
2. Включи переключатель **Enable Webhooks**
3. Выбери режим:
   - **IFTTT** — введи ключ из настроек IFTTT Webhooks
   - **Custom URL** — введи полный URL эндпоинта
4. Нажми **Test Connection** для проверки
5. Сохрани настройки

Кнопка теста отправляет событие `meshtastic_position` с тестовыми данными, не дожидаясь реального события сети.
