Content-Type: multipart/mixed; boundary="===============8596203329723595152=="
MIME-Version: 1.0
From: Shane Bryan <shane.bryan@linux.intel.com>
Subject: SEGV during offline with IFX modem
Date: Tue, 05 Apr 2011 12:50:23 -0700
Message-ID: <20110405125023.38a8d31c@sbryan-MOBL6>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8596203329723595152==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'm running into a crash (SIGSEGV) when using offline-modem script to
set the modem into offline mode.  Is this known behavior?  If so, is
there a bugzilla entry someplace for it?

Backtrace is attached.  Version is 0.41 from MeeGo Trunk RPM package [1]

I have a core with debug symbols available also, if that would be
helpful.

Shane...
[1]http://repo.meego.com/MeeGo/builds/trunk/1.1.99.0.20110329.5/repos/oss/i=
a32/packages/i586/ofono-0.41-2.1.i586.rpm

--===============8596203329723595152==
Content-Type: application/octet-stream
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ofonod-offline-segv.bt"

KGdkYikgYnQKIzAgIDB4NGQ4ODNiMTIgaW4gZ19zbGlzdF9yZW1vdmUgKCkgZnJvbSAvbGliL2xp
YmdsaWItMi4wLnNvLjAKIzEgIDB4MDgwZGYzOGYgaW4gZ3Byc19jb250ZXh0X3VucmVnaXN0ZXIg
KGF0b209MHg4MTU5ZTc4KSBhdCBzcmMvZ3Bycy5jOjIwMzYKIzIgIDB4MDgwYWYxYzAgaW4gX19v
Zm9ub19hdG9tX3VucmVnaXN0ZXIgKGF0b209MHg4MTU5ZTc4KSBhdCBzcmMvbW9kZW0uYzoyNDMK
IzMgIDB4MDgwYWYyOGIgaW4gZmx1c2hfYXRvbXMgKG1vZGVtPTB4ODE1ODI3OCwgbmV3X3N0YXRl
PU1PREVNX1NUQVRFX09GRkxJTkUpCiAgICBhdCBzcmMvbW9kZW0uYzozNTIKIzQgIG1vZGVtX2No
YW5nZV9zdGF0ZSAobW9kZW09MHg4MTU4Mjc4LCBuZXdfc3RhdGU9TU9ERU1fU1RBVEVfT0ZGTElO
RSkKICAgIGF0IHNyYy9tb2RlbS5jOjQwOQojNSAgMHgwODBhNjRkMCBpbiBzZXRfb25saW5lX2Ni
IChvaz0xLCByZXN1bHQ9MHhiZmZmZjVlOCwgdXNlcl9kYXRhPTB4ODE1YTI3MCkKICAgIGF0IHBs
dWdpbnMvaWZ4LmM6NjUyCiM2ICAweDA4MDZiZWQyIGluIGF0X2NoYXRfZmluaXNoX2NvbW1hbmQg
KHA9MHg4MTU3YmQ4LCBvaz0xLCAKICAgIGZpbmFsPTB4ODE2ZDVhMCAiT0siKSBhdCBnYXRjaGF0
L2dhdGNoYXQuYzo0NTYKIzcgIDB4MDgwNmNjZDcgaW4gYXRfY2hhdF9oYW5kbGVfY29tbWFuZF9y
ZXNwb25zZSAocmJ1Zj0weDgxNTdjOTAsIAogICAgdXNlcl9kYXRhPTB4ODE1N2JkOCkgYXQgZ2F0
Y2hhdC9nYXRjaGF0LmM6NTEyCiM4ICBoYXZlX2xpbmUgKHJidWY9MHg4MTU3YzkwLCB1c2VyX2Rh
dGE9MHg4MTU3YmQ4KSBhdCBnYXRjaGF0L2dhdGNoYXQuYzo1OTEKIzkgIG5ld19ieXRlcyAocmJ1
Zj0weDgxNTdjOTAsIHVzZXJfZGF0YT0weDgxNTdiZDgpIGF0IGdhdGNoYXQvZ2F0Y2hhdC5jOjc0
OQojMTAgMHgwODA2ZWM5NyBpbiByZWNlaXZlZF9kYXRhIChjaGFubmVsPTB4ODE1N2IzOCwgY29u
ZD1HX0lPX0lOLCAKICAgIGRhdGE9MHg4MTU3YzQ4KSBhdCBnYXRjaGF0L2dhdGlvLmM6MTIwCiMx
MSAweDA4MDZmN2ZkIGluIGRpc3BhdGNoX3NvdXJjZXMgKGNvbmRpdGlvbj1HX0lPX0lOLCAKICAg
IGNoYW5uZWw9PHZhbHVlIG9wdGltaXplZCBvdXQ+KSBhdCBnYXRjaGF0L2dhdG11eC5jOjE1NAoj
MTIgMHgwODA2ZmIzZSBpbiByZWNlaXZlZF9kYXRhIChjaGFubmVsPTB4ODE0YmIwMCwgY29uZD1H
X0lPX0lOLCAKICAgIGRhdGE9MHg4MTRjZmE4KSBhdCBnYXRjaGF0L2dhdG11eC5jOjIyMwojMTMg
MHg0ZDg3YzkzZiBpbiA/PyAoKSBmcm9tIC9saWIvbGliZ2xpYi0yLjAuc28uMAojMTQgMHg0ZDg0
N2MzNCBpbiBnX21haW5fY29udGV4dF9kaXNwYXRjaCAoKSBmcm9tIC9saWIvbGliZ2xpYi0yLjAu
c28uMAojMTUgMHg0ZDg0ODI1OCBpbiA/PyAoKSBmcm9tIC9saWIvbGliZ2xpYi0yLjAuc28uMAoj
MTYgMHg0ZDg0ODdmNiBpbiBnX21haW5fbG9vcF9ydW4gKCkgZnJvbSAvbGliL2xpYmdsaWItMi4w
LnNvLjAKIzE3IDB4MDgwYWRkNDkgaW4gbWFpbiAoYXJnYz0xLCBhcmd2PTB4YmZmZmZhODQpIGF0
IHNyYy9tYWluLmM6MjQzCgo=

--===============8596203329723595152==--

