# wsl-dns-fix

**A script to fix DNS resolution and DISPLAY forwarding in WSL2 on Windows 10**  
_...because running GUI apps on WSL2 without WSLg feels like you're bargaining with the kernel gods._

---

## What This Script Does

This script:

- Detects your **Windows host IP** from WSL2
- Adds it to `/etc/resolv.conf` **alongside Google's 8.8.8.8**
- Locks that file (`chattr +i`) to stop WSL2 from clobbering it every time it starts
- Sets the `$DISPLAY` variable so GUI apps (like Chromium or xeyes) can launch through **VcXsrv**
- Optionally adds that `$DISPLAY` export to your `~/.bashrc` so it sticks across sessions

---


> Because running GUI apps on WSL2 in Windows 10 is like teaching a fish to ride a bicycle.

Windows 11 has **WSLg**, where GUI apps "just work." Meanwhile on Windows 10, you’ve got to summon **VcXsrv**, patch up `$DISPLAY`, slap WSL around to fix DNS, and pray it all holds together with duct tape and sudo.

Yes, I wasted time on this.  
No, I will not upgrade to Windows 11.  
Yes, this script works.

---

## 🛠️ Requirements

- WSL2 on **Windows 10**
- `iproute2` (you probably already have it)
- `sudo` access inside WSL
- An X server running on Windows (e.g., [VcXsrv](https://sourceforge.net/projects/vcxsrv/))  
- At least one regret about trying to run GUI apps in WSL2

---

## 🚀 How to Use

1. Clone this repo or copy the script manually:

   ```bash
   git clone https://github.com/yourname/wsl-dns-fix.git
   cd wsl-dns-fix
