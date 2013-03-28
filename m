Content-Type: multipart/mixed; boundary="===============2284373082294749540=="
MIME-Version: 1.0
From: Freedreamer <freedreamer@email.it>
Subject: Re: SAGEM HiloNC v2 Driver
Date: Thu, 28 Mar 2013 14:40:56 +0100
Message-ID: <CAAs3wMgDDkOU7L8Po8CQ5upCBrjxN6a0D_KZ_wCJ0A2o2serXg@mail.gmail.com>
In-Reply-To: <51534E86.1040101@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2284373082294749540==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi again Denis..
so , I have now something  that seems to work properly also when SIM is
removed/ inserted.

here a the code I've been using;

http://pastebin.com/8VgKrYur

Got as always some question :)

1) The "set_online" function I copied from other drivers but is not never
called anyway...i'll tell more..if I enable it the ofono core stucks
somewhere..:|
2) seems that if  I set the same virtual com for the service "dev_info"  &
"sim"  I got a  crash of the stack...so i put them in 2 different channel
of the Mux.
3) ppp works only if when I got DNS & ip
     ifconfig ppp0  <ip>  up
     route add -net 0.0.0.0 ppp0



2013/3/27 Denis Kenzior <denkenz@gmail.com>

> Hi Marco,
>
>
>
>>     enable -> pre_sim, sim_inserted -> post_sim, set_online ->
>>     post_online.  Generally you do not call set_online before hitting
>>     the post_sim state.
>>
>>
>> could I don't  implement set_online if I don't need it?
>>
>
> That would work, if the modem driver does not implement set_online, oFono
> core automatically transitions to Online after CPIN returns 'READY'.
>
>
>
>>     <snip>
>>
>>
>>
>>         I've managing vendor URC for sim detection right now but i have
>>         problems.For instance if I remove it when ofonod is ready the
>> Hilonc
>>         sends an URC to notify sim status changed but after that it
>> reboots
>>         itself(2 sec later)... what i did is to notify the stack that
>>         the SIM
>>         has been removed and modem is powered off . I thought that after
>>         calling
>>         set_powered fnc the stack should have called my driver virtual
>>         disable
>>         function in order to properly close the MUX .. but it's not..
>>
>>
>>     No, if you call ofono_modem_set_powered(modem, FALSE) it assumes
>>     that the modem powered off due to an internally generated event
>>     (e.g. not oFono's doing).  The driver has to clean up properly in
>>     this case.  The driver disable() method is only called on oFono
>>     initiated power down requests.
>>
>>
>> mmh ok..so If the modem restarts it's my business to disable and enable
>> again all the driver' stuff , right?
>>
>>
> If the modem resets, then yes you need to call ofono_modem_set_powered to
> FALSE.  Booting it back up should not be done in the driver, unless your
> modem supports so called silent resets.  This is where the modem stack
> crashes but silently resets itself back to the previous state. (e.g. no P=
IN
> entry is required, initialization is very fast). In that case use
> ofono_modem_reset.
>
> <snip>
>
> Glad I could help ;)
>
> Regards,
> -Denis
>

--===============2284373082294749540==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgYWdhaW4gRGVuaXMuLjxicj5zbyAsIEkgaGF2ZSBub3cgc29tZXRoaW5noCB0aGF0IHNlZW1z
IHRvIHdvcmsgcHJvcGVybHkgYWxzbyB3aGVuIFNJTSBpcyByZW1vdmVkLyBpbnNlcnRlZC48YnI+
PGJyPmhlcmUgYSB0aGUgY29kZSBJJiMzOTt2ZSBiZWVuIHVzaW5nOzxicj48YnI+PGEgaHJlZj0i
aHR0cDovL3Bhc3RlYmluLmNvbS84VmdLcll1ciI+aHR0cDovL3Bhc3RlYmluLmNvbS84VmdLcll1
cjwvYT48YnI+Cjxicj5Hb3QgYXMgYWx3YXlzIHNvbWUgcXVlc3Rpb24gOik8YnI+PGJyPjEpIFRo
ZSAmcXVvdDtzZXRfb25saW5lJnF1b3Q7IGZ1bmN0aW9uIEkgY29waWVkIGZyb20gb3RoZXIgZHJp
dmVycyBidXQgaXMgbm90IG5ldmVyIGNhbGxlZCBhbnl3YXkuLi5pJiMzOTtsbCB0ZWxsIG1vcmUu
LmlmIEkgZW5hYmxlIGl0IHRoZSBvZm9ubyBjb3JlIHN0dWNrcyBzb21ld2hlcmUuLjp8PGJyPjIp
IHNlZW1zIHRoYXQgaWagIEkgc2V0IHRoZSBzYW1lIHZpcnR1YWwgY29tIGZvciB0aGUgc2Vydmlj
ZSAmcXVvdDtkZXZfaW5mbyZxdW90O6AgJmFtcDsgJnF1b3Q7c2ltJnF1b3Q7oCBJIGdvdCBhoCBj
cmFzaCBvZiB0aGUgc3RhY2suLi5zbyBpIHB1dCB0aGVtIGluIDIgZGlmZmVyZW50IGNoYW5uZWwg
b2YgdGhlIE11eC48YnI+CjMpIHBwcCB3b3JrcyBvbmx5IGlmIHdoZW4gSSBnb3QgRE5TICZhbXA7
IGlwIDxicj6goKCgIGlmY29uZmlnIHBwcDCgICZsdDtpcCZndDugIHVwPGJyPqCgoKAgcm91dGUg
YWRkIC1uZXQgMC4wLjAuMCBwcHAwPGJyPjxicj48YnI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1
b3RlIj4yMDEzLzMvMjcgRGVuaXMgS2VuemlvciA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9
Im1haWx0bzpkZW5rZW56QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmRlbmtlbnpAZ21haWwu
Y29tPC9hPiZndDs8L3NwYW4+PGJyPgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0
eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5n
LWxlZnQ6MWV4Ij5IaSBNYXJjbyw8ZGl2IGNsYXNzPSJpbSI+PGJyPgo8YnI+CjxibG9ja3F1b3Rl
IGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0
OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgo8YnI+CqAgoCBlbmFibGUgLSZndDsg
cHJlX3NpbSwgc2ltX2luc2VydGVkIC0mZ3Q7IHBvc3Rfc2ltLCBzZXRfb25saW5lIC0mZ3Q7PGJy
PgqgIKAgcG9zdF9vbmxpbmUuIKBHZW5lcmFsbHkgeW91IGRvIG5vdCBjYWxsIHNldF9vbmxpbmUg
YmVmb3JlIGhpdHRpbmc8YnI+CqAgoCB0aGUgcG9zdF9zaW0gc3RhdGUuPGJyPgo8YnI+Cjxicj4K
Y291bGQgSSBkb24mIzM5O3QgoGltcGxlbWVudCBzZXRfb25saW5lIGlmIEkgZG9uJiMzOTt0IG5l
ZWQgaXQ/PGJyPgo8L2Jsb2NrcXVvdGU+Cjxicj48L2Rpdj4KVGhhdCB3b3VsZCB3b3JrLCBpZiB0
aGUgbW9kZW0gZHJpdmVyIGRvZXMgbm90IGltcGxlbWVudCBzZXRfb25saW5lLCBvRm9ubyBjb3Jl
IGF1dG9tYXRpY2FsbHkgdHJhbnNpdGlvbnMgdG8gT25saW5lIGFmdGVyIENQSU4gcmV0dXJucyAm
IzM5O1JFQURZJiMzOTsuPGRpdiBjbGFzcz0iaW0iPjxicj4KPGJyPgo8YmxvY2txdW90ZSBjbGFz
cz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHgg
I2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KPGJyPgqgIKAgJmx0O3NuaXAmZ3Q7PGJyPgo8
YnI+Cjxicj4KPGJyPgqgIKAgoCCgIEkmIzM5O3ZlIG1hbmFnaW5nIHZlbmRvciBVUkMgZm9yIHNp
bSBkZXRlY3Rpb24gcmlnaHQgbm93IGJ1dCBpIGhhdmU8YnI+CqAgoCCgIKAgcHJvYmxlbXMuRm9y
IGluc3RhbmNlIGlmIEkgcmVtb3ZlIGl0IHdoZW4gb2Zvbm9kIGlzIHJlYWR5IHRoZSBIaWxvbmM8
YnI+CqAgoCCgIKAgc2VuZHMgYW4gVVJDIHRvIG5vdGlmeSBzaW0gc3RhdHVzIGNoYW5nZWQgYnV0
IGFmdGVyIHRoYXQgaXQgcmVib290czxicj4KoCCgIKAgoCBpdHNlbGYoMiBzZWMgbGF0ZXIpLi4u
IHdoYXQgaSBkaWQgaXMgdG8gbm90aWZ5IHRoZSBzdGFjayB0aGF0PGJyPgqgIKAgoCCgIHRoZSBT
SU08YnI+CqAgoCCgIKAgaGFzIGJlZW4gcmVtb3ZlZCBhbmQgbW9kZW0gaXMgcG93ZXJlZCBvZmYg
LiBJIHRob3VnaHQgdGhhdCBhZnRlcjxicj4KoCCgIKAgoCBjYWxsaW5nPGJyPgqgIKAgoCCgIHNl
dF9wb3dlcmVkIGZuYyB0aGUgc3RhY2sgc2hvdWxkIGhhdmUgY2FsbGVkIG15IGRyaXZlciB2aXJ0
dWFsPGJyPgqgIKAgoCCgIGRpc2FibGU8YnI+CqAgoCCgIKAgZnVuY3Rpb24gaW4gb3JkZXIgdG8g
cHJvcGVybHkgY2xvc2UgdGhlIE1VWCAuLiBidXQgaXQmIzM5O3Mgbm90Li48YnI+Cjxicj4KPGJy
PgqgIKAgTm8sIGlmIHlvdSBjYWxsIG9mb25vX21vZGVtX3NldF9wb3dlcmVkKG1vZGVtLCBGQUxT
RSkgaXQgYXNzdW1lczxicj4KoCCgIHRoYXQgdGhlIG1vZGVtIHBvd2VyZWQgb2ZmIGR1ZSB0byBh
biBpbnRlcm5hbGx5IGdlbmVyYXRlZCBldmVudDxicj4KoCCgIChlLmcuIG5vdCBvRm9ubyYjMzk7
cyBkb2luZykuIKBUaGUgZHJpdmVyIGhhcyB0byBjbGVhbiB1cCBwcm9wZXJseSBpbjxicj4KoCCg
IHRoaXMgY2FzZS4goFRoZSBkcml2ZXIgZGlzYWJsZSgpIG1ldGhvZCBpcyBvbmx5IGNhbGxlZCBv
biBvRm9ubzxicj4KoCCgIGluaXRpYXRlZCBwb3dlciBkb3duIHJlcXVlc3RzLjxicj4KPGJyPgo8
YnI+Cm1taCBvay4uc28gSWYgdGhlIG1vZGVtIHJlc3RhcnRzIGl0JiMzOTtzIG15IGJ1c2luZXNz
IHRvIGRpc2FibGUgYW5kIGVuYWJsZTxicj4KYWdhaW4gYWxsIHRoZSBkcml2ZXImIzM5OyBzdHVm
ZiAsIHJpZ2h0Pzxicj4KPGJyPgo8L2Jsb2NrcXVvdGU+Cjxicj48L2Rpdj4KSWYgdGhlIG1vZGVt
IHJlc2V0cywgdGhlbiB5ZXMgeW91IG5lZWQgdG8gY2FsbCBvZm9ub19tb2RlbV9zZXRfcG93ZXJl
ZCB0byBGQUxTRS4goEJvb3RpbmcgaXQgYmFjayB1cCBzaG91bGQgbm90IGJlIGRvbmUgaW4gdGhl
IGRyaXZlciwgdW5sZXNzIHlvdXIgbW9kZW0gc3VwcG9ydHMgc28gY2FsbGVkIHNpbGVudCByZXNl
dHMuIKBUaGlzIGlzIHdoZXJlIHRoZSBtb2RlbSBzdGFjayBjcmFzaGVzIGJ1dCBzaWxlbnRseSBy
ZXNldHMgaXRzZWxmIGJhY2sgdG8gdGhlIHByZXZpb3VzIHN0YXRlLiAoZS5nLiBubyBQSU4gZW50
cnkgaXMgcmVxdWlyZWQsIGluaXRpYWxpemF0aW9uIGlzIHZlcnkgZmFzdCkuIEluIHRoYXQgY2Fz
ZSB1c2Ugb2Zvbm9fbW9kZW1fcmVzZXQuPGJyPgoKPGJyPgombHQ7c25pcCZndDs8YnI+Cjxicj4K
R2xhZCBJIGNvdWxkIGhlbHAgOyk8YnI+Cjxicj4KUmVnYXJkcyw8YnI+Ci1EZW5pczxicj4KPC9i
bG9ja3F1b3RlPjwvZGl2Pjxicj4K

--===============2284373082294749540==--

