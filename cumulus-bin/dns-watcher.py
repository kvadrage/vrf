root@kenny-jessie3:~# cat resolv-watcher.py
" Based on
" http://www.saltycrane.com/blog/2010/04/monitoring-filesystem-python-and-pyinotify/

import pyinotify

" for each event read nameserver entries
" flush old rules and add new one for each nameserver

class MyEventHandler(pyinotify.ProcessEvent):
    def process_IN_CLOSE_WRITE(self, event):
        print "CLOSE_WRITE event:", event.pathname

    def process_IN_CREATE(self, event):
        print "CREATE event:", event.pathname

    def process_IN_DELETE(self, event):
        print "DELETE event:", event.pathname

    def process_IN_MODIFY(self, event):
        print "MODIFY event:", event.pathname

def main():
    # watch manager
    wm = pyinotify.WatchManager()
    wm.add_watch('/etc/resolv.conf', pyinotify.ALL_EVENTS, rec=True)

    # event handler
    eh = MyEventHandler()

    # notifier
    notifier = pyinotify.Notifier(wm, eh)
    notifier.loop()

if __name__ == '__main__':
    main()
