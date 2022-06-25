import WindowStatus from '../../models/WindowStatus'
import Window from '../../models/Window'

export const saveWindowStatus = async (payload) => {
    const {window,status} = payload
    const newWindow = new WindowStatus({
        window:window,
        status:status
    });
    try {
        const findWindow = Window.findById(window)
        if(!findWindow) return false

        await Window.findByIdAndUpdate(
            {_id:window},
            {status:status}
        )

        await newWindow.save()
        return true
    } catch (error) {
        return false
    }

}