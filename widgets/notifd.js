import Notifd from "gi://AstalNotifd"

const notifd = Notifd.get_default()

notifd.connect("notified", (_, id) => {
    const n = notifd.get_notification(id)
    print(n.summary, n.body)
})
