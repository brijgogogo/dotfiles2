from qutebrowser.api import interceptor
from themeDracula import blood
# import themeGruvbox

config.load_autoconfig(False)

####
#### themes
####
# config.source(str(config.configdir / 'custom_themes/gruvbox.py'))
# Dracula theme
blood(c, {
    'spacing': {
        'vertical': 6,
        'horizontal': 8
    }
})

# c.tabs.position = "left"
# c.completion.shrink = True
# c.url.start_pages = ["https://www.google.com"]


####
#### Block Youtube
####
def filter_yt(info: interceptor.Request):
    """Block the given request if necessary."""
    url = info.request_url
    if (
        url.host() == "www.youtube.com"
        and url.path() == "/get_video_info"
        and "&adformat=" in url.query()
    ):
        info.block()


interceptor.register(filter_yt)



# C-e to open editor
c.editor.command = ["alacritty", "-e", "nvim", "{}"]

c.auto_save.session = True
c.content.autoplay = False

# Tabs
c.tabs.background = True
c.tabs.last_close = "default-page"
c.tabs.mousewheel_switching = False
c.tabs.position = "left"
c.tabs.select_on_remove = "next"
c.tabs.show = "multiple"
c.tabs.title.format = "{audio} {current_title}"
c.tabs.width = "15%"

# Darkmode
c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.darkmode.enabled = True

# Bindings for normal mode
config.bind("<", "tab-move -")
config.bind(">", "tab-move +")
config.bind("<Ctrl+Shift+Tab>", "tab-prev")
config.bind("<Ctrl+Tab>", "tab-next")

# Play media in mpv
# uses playlist so can add multiple, use >, < for next/prev
# install umpv
config.bind("M", "hint links spawn umpv {hint-url}")
