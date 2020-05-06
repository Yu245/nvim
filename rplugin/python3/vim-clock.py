from datetime import datetime
import time
import neovim

@neovim.plugin
class VimClock(object):
    
    def __init__(self, nvim):
        self.nvim = nvim

    @neovim.function("TestFunction", sync=True)
    def testfunction(self, args):
        return 3

    @neovim.command("StartClock", range='', nargs='*')
    def clock(self, args, range):
        #self.CreateNewWindow()
        i = 0
        clock_time = ''
        while True:
            clock_time_buf = datetime.now().strftime('%H:%M')
            if clock_time != clock_time_buf:
                clock_time = clock_time_buf
                #self.nvim.current.line = (clock_time)
                self.nvim.vars['Clock'] = clock_time
            time.sleep(1)

    def CreateNewWindow(self):
        self.nvim.command('split')
        self.nvim.windows[1].height = 1

