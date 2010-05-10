Content-Type: multipart/mixed; boundary="===============2007976994823205635=="
MIME-Version: 1.0
From: krishna k <id_kishore@live.in>
Subject: How to start ofono-phonesim in ubuntu-10.04 -reg
Date: Mon, 10 May 2010 14:21:13 +0530
Message-ID: <COL106-W440EC879DB0008278775A2F6F90@phx.gbl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2007976994823205635==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Zhenhua,
    =

   I installed ofono-phonesim from Synaptic Package Manager (Ubuntu Lucid h=
ave this facility). I guess it is with =

bootscrap-configure only. So that I am able to find ofono directory in /etc=
 (/etc/ofono). I placed my modem.conf file =

inside /etc/ofono.  =


After that also it is giving the same problem... I tried to list the modem =
with the following command...


./ofono/test/list-modems =


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
Traceback (most recent call last):
  File "./ofono/test/list-modems", line 7, in <module>
    manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
  File "/usr/lib/pymodules/python2.6/dbus/bus.py", line 244, in get_object
    follow_name_owner_changes=3Dfollow_name_owner_changes)
  File "/usr/lib/pymodules/python2.6/dbus/proxies.py", line 241, in __init__
    self._named_service =3D conn.activate_name_owner(bus_name)
  File "/usr/lib/pymodules/python2.6/dbus/bus.py", line 183, in activate_na=
me_owner
    self.start_service_by_name(bus_name)
  File "/usr/lib/pymodules/python2.6/dbus/bus.py", line 281, in start_servi=
ce_by_name
    'su', (bus_name, flags)))
  File "/usr/lib/pymodules/python2.6/dbus/connection.py", line 620, in call=
_blocking
    message, timeout)
dbus.exceptions.DBusException: org.freedesktop.DBus.Error.ServiceUnknown: T=
he name org.ofono was not provided by any .service files

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

regards,
Krishna K Kandula.

Hi Krishna,

	From: ofono-bounces at ofono.org [mailto:ofono-bounces at ofono.org] On Be=
half Of krishna k
	Sent: Monday, May 10, 2010 4:13 PM
	To: ofono at ofono.org
	Subject: How to start ofono-phonesim in ubuntu-10.04 -reg
	=

	=

	Hi Yoon, =

	=

	I placed modem.conf file under /etc/ofono, and i tried with ./test/list-mo=
dems script. Still it is not showing any =

	thing on command line.  I tried to enable the phonesim0 modem with followi=
ng command and i am getting the same o/p

[Zhenhua] Do you build oFono with bootscrap-configure? If does, you will ha=
ve '--prefix=3D/usr --sysconfdir=3D/etc ...' configuration. So oFono reads =
configuration from /etc/ofono. Without that, you might put modem.conf under=
 /usr/local/etc/ofono. Btw, you could raise your question on our IRC room #=
ofono at irc.freenode.net as well.
	=

	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	=

	./enable-modem /phonesim0
	=

	******************etc.....
	=

	dbus.exceptions.DBusException: org.freedesktop.DBus.Error.UnknownMethod: M=
ethod "SetProperty" =

	with signature "sb" on interface "org.ofono.Modem" doesn't exist.
	=

	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	=

	The same error as below. It is not able to detect the phonesim0?
	=

	regards,
	Krishna K Kandula.
	=

	Hi Krishna,
	=

	You should put your modem.conf file under /etc/ofono/.
	=

	Thanks,
	Yoon
	=

	From: ofono-bounces at ofono.org <http://lists.ofono.org/listinfo/ofono>  =
[mailto:ofono-bounces at ofono.org <http://lists.ofono.org/listinfo/ofono> =
] On Behalf Of krishna k
	Sent: Monday, May 10, 2010 3:43 PM
	To: ofono at ofono.org <http://lists.ofono.org/listinfo/ofono> =

	Subject: How to start ofono-phonesim in ubuntu-10.04 -reg
	=

	=

	Hi Zhenhua,
	=

	Thanks for your reply..
	=

	I added the following code in /usr/share/alsa/pcm/modem.conf file...
	=

	1.
	#
	#Sample for using phone simulator
	#
	[phonesim]
	Driver=3Dphonesim
	Address=3D127.0.0.1
	port=3D12345
	=

	--------------------------------------------------------------------------=
---------------------------------------------------------------
	I tried to ./list_modems. I got nothing on command prompt. According to my=
 knowledge i should get the available modems (atleast phonesim0)
	I tried to enable  the modem using the following command..
	=

	./enable-modem /phonesim0
	=

	I got =

	output as follows...
	=

	--------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------------------------------
	=

	Connecting
	 modem /phonesim0...
	=

	Traceback =

	(most recent call last):
	=

	  File =

	"./enable-modem", line 20, in <module>
	=

	    =

	modem.SetProperty("Powered", dbus.Boolean(1))
	=

	  File =

	"/usr/lib/pymodules/python2.6/dbus/proxies.py", line 68, in __call__
	=

	    return
	 self._proxy_method(*args, **keywords)
	=

	  File =

	"/usr/lib/pymodules/python2.6/dbus/proxies.py", line 140, in __call__
	=

	    =

	**keywords)
	=

	  File =

	"/usr/lib/pymodules/python2.6/dbus/connection.py", line 620, in =

	call_blocking
	=

	    =

	message, timeout)
	=

	dbus.exceptions.DBusException:
	 org.freedesktop.DBus.Error.UnknownMethod: Method "SetProperty" with =

	signature "sb" on interface "org.ofono.Modem" doesn't exist
	=

	--------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------
	Have a nice time.
	=

	Regards,
	Krishna K Kandula
 		 	   		  =

_________________________________________________________________
South Cinema This Decade
http://entertainment.in.msn.com/southcinemathisdecade/

--===============2007976994823205635==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CjxoZWFkPgo8c3R5bGU+PCEtLQouaG1tZXNzYWdlIFAKewptYXJnaW46MHB4OwpwYWRk
aW5nOjBweAp9CmJvZHkuaG1tZXNzYWdlCnsKZm9udC1zaXplOiAxMHB0Owpmb250LWZhbWlseTpW
ZXJkYW5hCn0KLS0+PC9zdHlsZT4KPC9oZWFkPgo8Ym9keSBjbGFzcz0naG1tZXNzYWdlJz4KPHBy
ZT5IaSBaaGVuaHVhLDxicj4gICAgPGJyPiAgIEkgaW5zdGFsbGVkIG9mb25vLXBob25lc2ltIGZy
b20gU3luYXB0aWMgUGFja2FnZSBNYW5hZ2VyIChVYnVudHUgTHVjaWQgaGF2ZSB0aGlzIGZhY2ls
aXR5KS4gSSBndWVzcyBpdCBpcyB3aXRoIDxicj5ib290c2NyYXAtY29uZmlndXJlIG9ubHkuIFNv
IHRoYXQgSSBhbSBhYmxlIHRvIGZpbmQgb2Zvbm8gZGlyZWN0b3J5IGluIC9ldGMgKC9ldGMvb2Zv
bm8pLiBJIHBsYWNlZCBteSBtb2RlbS5jb25mIGZpbGUgPGJyPmluc2lkZSAvZXRjL29mb25vLiAg
PGJyPjxicj5BZnRlciB0aGF0IGFsc28gaXQgaXMgZ2l2aW5nIHRoZSBzYW1lIHByb2JsZW0uLi4g
SSB0cmllZCB0byBsaXN0IHRoZSBtb2RlbSB3aXRoIHRoZSBmb2xsb3dpbmcgY29tbWFuZC4uLjxi
cj48YnI+PGJyPi4vb2Zvbm8vdGVzdC9saXN0LW1vZGVtcyA8YnI+PGJyPj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT08
YnI+VHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOjxicj4gIEZpbGUgIi4vb2Zvbm8v
dGVzdC9saXN0LW1vZGVtcyIsIGxpbmUgNywgaW4gJmx0O21vZHVsZSZndDs8YnI+ICAgIG1hbmFn
ZXIgPSBkYnVzLkludGVyZmFjZShidXMuZ2V0X29iamVjdCgnb3JnLm9mb25vJywgJy8nKSw8YnI+
ICBGaWxlICIvdXNyL2xpYi9weW1vZHVsZXMvcHl0aG9uMi42L2RidXMvYnVzLnB5IiwgbGluZSAy
NDQsIGluIGdldF9vYmplY3Q8YnI+ICAgIGZvbGxvd19uYW1lX293bmVyX2NoYW5nZXM9Zm9sbG93
X25hbWVfb3duZXJfY2hhbmdlcyk8YnI+ICBGaWxlICIvdXNyL2xpYi9weW1vZHVsZXMvcHl0aG9u
Mi42L2RidXMvcHJveGllcy5weSIsIGxpbmUgMjQxLCBpbiBfX2luaXRfXzxicj4gICAgc2VsZi5f
bmFtZWRfc2VydmljZSA9IGNvbm4uYWN0aXZhdGVfbmFtZV9vd25lcihidXNfbmFtZSk8YnI+ICBG
aWxlICIvdXNyL2xpYi9weW1vZHVsZXMvcHl0aG9uMi42L2RidXMvYnVzLnB5IiwgbGluZSAxODMs
IGluIGFjdGl2YXRlX25hbWVfb3duZXI8YnI+ICAgIHNlbGYuc3RhcnRfc2VydmljZV9ieV9uYW1l
KGJ1c19uYW1lKTxicj4gIEZpbGUgIi91c3IvbGliL3B5bW9kdWxlcy9weXRob24yLjYvZGJ1cy9i
dXMucHkiLCBsaW5lIDI4MSwgaW4gc3RhcnRfc2VydmljZV9ieV9uYW1lPGJyPiAgICAnc3UnLCAo
YnVzX25hbWUsIGZsYWdzKSkpPGJyPiAgRmlsZSAiL3Vzci9saWIvcHltb2R1bGVzL3B5dGhvbjIu
Ni9kYnVzL2Nvbm5lY3Rpb24ucHkiLCBsaW5lIDYyMCwgaW4gY2FsbF9ibG9ja2luZzxicj4gICAg
bWVzc2FnZSwgdGltZW91dCk8YnI+ZGJ1cy5leGNlcHRpb25zLkRCdXNFeGNlcHRpb246IG9yZy5m
cmVlZGVza3RvcC5EQnVzLkVycm9yLlNlcnZpY2VVbmtub3duOiBUaGUgbmFtZSBvcmcub2Zvbm8g
d2FzIG5vdCBwcm92aWRlZCBieSBhbnkgLnNlcnZpY2UgZmlsZXM8YnI+PGJyPj09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT08YnI+PGJyPnJlZ2FyZHMsPGJyPktyaXNobmEgSyBLYW5kdWxhLjxicj48YnI+SGkgS3Jpc2hu
YSw8YnI+PGJyPglGcm9tOiA8YSBocmVmPSJodHRwOi8vbGlzdHMub2Zvbm8ub3JnL2xpc3RpbmZv
L29mb25vIj5vZm9uby1ib3VuY2VzIGF0IG9mb25vLm9yZzwvYT4gW21haWx0bzo8YSBocmVmPSJo
dHRwOi8vbGlzdHMub2Zvbm8ub3JnL2xpc3RpbmZvL29mb25vIj5vZm9uby1ib3VuY2VzIGF0IG9m
b25vLm9yZzwvYT5dIE9uIEJlaGFsZiBPZiBrcmlzaG5hIGs8YnI+CVNlbnQ6IE1vbmRheSwgTWF5
IDEwLCAyMDEwIDQ6MTMgUE08YnI+CVRvOiA8YSBocmVmPSJodHRwOi8vbGlzdHMub2Zvbm8ub3Jn
L2xpc3RpbmZvL29mb25vIj5vZm9ubyBhdCBvZm9uby5vcmc8L2E+PGJyPglTdWJqZWN0OiBIb3cg
dG8gc3RhcnQgb2Zvbm8tcGhvbmVzaW0gaW4gdWJ1bnR1LTEwLjA0IC1yZWc8YnI+CTxicj4JPGJy
PglIaSBZb29uLCA8YnI+CTxicj4JSSBwbGFjZWQgbW9kZW0uY29uZiBmaWxlIHVuZGVyIC9ldGMv
b2Zvbm8sIGFuZCBpIHRyaWVkIHdpdGggLi90ZXN0L2xpc3QtbW9kZW1zIHNjcmlwdC4gU3RpbGwg
aXQgaXMgbm90IHNob3dpbmcgYW55IDxicj4JdGhpbmcgb24gY29tbWFuZCBsaW5lLiAgSSB0cmll
ZCB0byBlbmFibGUgdGhlIHBob25lc2ltMCBtb2RlbSB3aXRoIGZvbGxvd2luZyBjb21tYW5kIGFu
ZCBpIGFtIGdldHRpbmcgdGhlIHNhbWUgby9wPGJyPjxicj5bWmhlbmh1YV0gRG8geW91IGJ1aWxk
IG9Gb25vIHdpdGggYm9vdHNjcmFwLWNvbmZpZ3VyZT8gSWYgZG9lcywgeW91IHdpbGwgaGF2ZSAn
LS1wcmVmaXg9L3VzciAtLXN5c2NvbmZkaXI9L2V0YyAuLi4nIGNvbmZpZ3VyYXRpb24uIFNvIG9G
b25vIHJlYWRzIGNvbmZpZ3VyYXRpb24gZnJvbSAvZXRjL29mb25vLiBXaXRob3V0IHRoYXQsIHlv
dSBtaWdodCBwdXQgbW9kZW0uY29uZiB1bmRlciAvdXNyL2xvY2FsL2V0Yy9vZm9uby4gQnR3LCB5
b3UgY291bGQgcmFpc2UgeW91ciBxdWVzdGlvbiBvbiBvdXIgSVJDIHJvb20gI29mb25vIGF0IGly
Yy5mcmVlbm9kZS5uZXQgYXMgd2VsbC48YnI+CTxicj4JPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PTxicj4JPGJyPgkuL2VuYWJsZS1t
b2RlbSAvcGhvbmVzaW0wPGJyPgk8YnI+CSoqKioqKioqKioqKioqKioqKmV0Yy4uLi4uPGJyPgk8
YnI+CWRidXMuZXhjZXB0aW9ucy5EQnVzRXhjZXB0aW9uOiBvcmcuZnJlZWRlc2t0b3AuREJ1cy5F
cnJvci5Vbmtub3duTWV0aG9kOiBNZXRob2QgIlNldFByb3BlcnR5IiA8YnI+CXdpdGggc2lnbmF0
dXJlICJzYiIgb24gaW50ZXJmYWNlICJvcmcub2Zvbm8uTW9kZW0iIGRvZXNuJ3QgZXhpc3QuPGJy
Pgk8YnI+CT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT08YnI+CTxicj4JVGhlIHNhbWUgZXJyb3IgYXMgYmVsb3cuIEl0IGlzIG5vdCBh
YmxlIHRvIGRldGVjdCB0aGUgcGhvbmVzaW0wPzxicj4JPGJyPglyZWdhcmRzLDxicj4JS3Jpc2hu
YSBLIEthbmR1bGEuPGJyPgk8YnI+CUhpIEtyaXNobmEsPGJyPgk8YnI+CVlvdSBzaG91bGQgcHV0
IHlvdXIgbW9kZW0uY29uZiBmaWxlIHVuZGVyIC9ldGMvb2Zvbm8vLjxicj4JPGJyPglUaGFua3Ms
PGJyPglZb29uPGJyPgk8YnI+CUZyb206IG9mb25vLWJvdW5jZXMgYXQgb2Zvbm8ub3JnICZsdDs8
YSBocmVmPSJodHRwOi8vbGlzdHMub2Zvbm8ub3JnL2xpc3RpbmZvL29mb25vIj5odHRwOi8vbGlz
dHMub2Zvbm8ub3JnL2xpc3RpbmZvL29mb25vPC9hPiZndDsgIFttYWlsdG86b2Zvbm8tYm91bmNl
cyBhdCBvZm9uby5vcmcgJmx0OzxhIGhyZWY9Imh0dHA6Ly9saXN0cy5vZm9uby5vcmcvbGlzdGlu
Zm8vb2Zvbm8iPmh0dHA6Ly9saXN0cy5vZm9uby5vcmcvbGlzdGluZm8vb2Zvbm88L2E+Jmd0OyBd
IE9uIEJlaGFsZiBPZiBrcmlzaG5hIGs8YnI+CVNlbnQ6IE1vbmRheSwgTWF5IDEwLCAyMDEwIDM6
NDMgUE08YnI+CVRvOiBvZm9ubyBhdCBvZm9uby5vcmcgJmx0OzxhIGhyZWY9Imh0dHA6Ly9saXN0
cy5vZm9uby5vcmcvbGlzdGluZm8vb2Zvbm8iPmh0dHA6Ly9saXN0cy5vZm9uby5vcmcvbGlzdGlu
Zm8vb2Zvbm88L2E+Jmd0OyA8YnI+CVN1YmplY3Q6IEhvdyB0byBzdGFydCBvZm9uby1waG9uZXNp
bSBpbiB1YnVudHUtMTAuMDQgLXJlZzxicj4JPGJyPgk8YnI+CUhpIFpoZW5odWEsPGJyPgk8YnI+
CVRoYW5rcyBmb3IgeW91ciByZXBseS4uPGJyPgk8YnI+CUkgYWRkZWQgdGhlIGZvbGxvd2luZyBj
b2RlIGluIC91c3Ivc2hhcmUvYWxzYS9wY20vbW9kZW0uY29uZiBmaWxlLi4uPGJyPgk8YnI+CTEu
PGJyPgkjPGJyPgkjU2FtcGxlIGZvciB1c2luZyBwaG9uZSBzaW11bGF0b3I8YnI+CSM8YnI+CVtw
aG9uZXNpbV08YnI+CURyaXZlcj1waG9uZXNpbTxicj4JQWRkcmVzcz0xMjcuMC4wLjE8YnI+CXBv
cnQ9MTIzNDU8YnI+CTxicj4JLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+CUkgdHJpZWQgdG8g
Li9saXN0X21vZGVtcy4gSSBnb3Qgbm90aGluZyBvbiBjb21tYW5kIHByb21wdC4gQWNjb3JkaW5n
IHRvIG15IGtub3dsZWRnZSBpIHNob3VsZCBnZXQgdGhlIGF2YWlsYWJsZSBtb2RlbXMgKGF0bGVh
c3QgcGhvbmVzaW0wKTxicj4JSSB0cmllZCB0byBlbmFibGUgIHRoZSBtb2RlbSB1c2luZyB0aGUg
Zm9sbG93aW5nIGNvbW1hbmQuLjxicj4JPGJyPgkuL2VuYWJsZS1tb2RlbSAvcGhvbmVzaW0wPGJy
Pgk8YnI+CUkgZ290IDxicj4Jb3V0cHV0IGFzIGZvbGxvd3MuLi48YnI+CTxicj4JLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLTxicj4JPGJyPglDb25uZWN0aW5nPGJyPgkgbW9kZW0gL3Bob25lc2ltMC4uLjxi
cj4JPGJyPglUcmFjZWJhY2sgPGJyPgkobW9zdCByZWNlbnQgY2FsbCBsYXN0KTo8YnI+CTxicj4J
ICBGaWxlIDxicj4JIi4vZW5hYmxlLW1vZGVtIiwgbGluZSAyMCwgaW4gJmx0O21vZHVsZSZndDs8
YnI+CTxicj4JICAgIDxicj4JbW9kZW0uU2V0UHJvcGVydHkoIlBvd2VyZWQiLCBkYnVzLkJvb2xl
YW4oMSkpPGJyPgk8YnI+CSAgRmlsZSA8YnI+CSIvdXNyL2xpYi9weW1vZHVsZXMvcHl0aG9uMi42
L2RidXMvcHJveGllcy5weSIsIGxpbmUgNjgsIGluIF9fY2FsbF9fPGJyPgk8YnI+CSAgICByZXR1
cm48YnI+CSBzZWxmLl9wcm94eV9tZXRob2QoKmFyZ3MsICoqa2V5d29yZHMpPGJyPgk8YnI+CSAg
RmlsZSA8YnI+CSIvdXNyL2xpYi9weW1vZHVsZXMvcHl0aG9uMi42L2RidXMvcHJveGllcy5weSIs
IGxpbmUgMTQwLCBpbiBfX2NhbGxfXzxicj4JPGJyPgkgICAgPGJyPgkqKmtleXdvcmRzKTxicj4J
PGJyPgkgIEZpbGUgPGJyPgkiL3Vzci9saWIvcHltb2R1bGVzL3B5dGhvbjIuNi9kYnVzL2Nvbm5l
Y3Rpb24ucHkiLCBsaW5lIDYyMCwgaW4gPGJyPgljYWxsX2Jsb2NraW5nPGJyPgk8YnI+CSAgICA8
YnI+CW1lc3NhZ2UsIHRpbWVvdXQpPGJyPgk8YnI+CWRidXMuZXhjZXB0aW9ucy5EQnVzRXhjZXB0
aW9uOjxicj4JIG9yZy5mcmVlZGVza3RvcC5EQnVzLkVycm9yLlVua25vd25NZXRob2Q6IE1ldGhv
ZCAiU2V0UHJvcGVydHkiIHdpdGggPGJyPglzaWduYXR1cmUgInNiIiBvbiBpbnRlcmZhY2UgIm9y
Zy5vZm9uby5Nb2RlbSIgZG9lc24ndCBleGlzdDxicj4JPGJyPgktLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLTxicj4JSGF2ZSBhIG5pY2UgdGltZS48YnI+CTxicj4JUmVnYXJkcyw8YnI+CUtyaXNobmEg
SyBLYW5kdWxhPGJyPjwvcHJlPiAJCSAJICAgCQkgIDxiciAvPjxociAvPlRoZSBsYXRlc3QgYXV0
byBsYXVuY2hlcyBhbmQgdGVzdCBkcml2ZXMgPGEgaHJlZj0naHR0cDovL2F1dG9zLmluLm1zbi5j
b20vJyB0YXJnZXQ9J19uZXcnPkRyYWcgbicgZHJvcDwvYT48L2JvZHk+CjwvaHRtbD4=
--===============2007976994823205635==--

