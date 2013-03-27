Content-Type: multipart/mixed; boundary="===============7057713443736802978=="
MIME-Version: 1.0
From: Freedreamer <freedreamer@email.it>
Subject: Re: SAGEM HiloNC v2 Driver
Date: Wed, 27 Mar 2013 19:06:59 +0100
Message-ID: <CAAs3wMjfWfeog=+ECLZZjYEMwNL6nh4fn=phARSwVs06dt9u5A@mail.gmail.com>
In-Reply-To: <515303DB.7020105@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7057713443736802978==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Tnx again 4 your patience Denis,


2013/3/27 Denis Kenzior <denkenz@gmail.com>

> Hi Marco,
>
> <snip>
>
>
>              2) in enable fnc the modem is powered but The sim is not
>>             ready so
>>             sometimes It hangs up...Do I have to to poll the sim status
>>             until is
>>             ready  , or the driver will do  that by itself ?
>>
>>
>>         oFono never polls for anything.  It is the driver's
>>         responsibility to do that in the best possible way for the
>>         hardware.  Also, powering on the modem is separate from the sim
>>         being ready.  The general flow is this:
>>
>>         -Enable modem
>>         -Wait for the modem to power on and use ofono_modem_set_powered
>>         when that happens successfully / fails.
>>         - Figure out if the SIM is inserted and signal using
>>         ofono_sim_inserted_notify.  Do this step only once the SIM is
>>         ready to be queried for its PIN status and perform any I/O on
>>         SIM files that are always accessible (e.g. ICCID)
>>
>>
>> Ok. If Sim not "ready" , sending a signal prematurely could stuck anyhow
>> the stack ? 'cause it should explain a lot of thing..
>>
>>
> If you tell oFono core that the sim is inserted, the first thing it does
> is read some sim files that are always available.  e.g. ICCID, etc. Then =
it
> proceeds to check the PIN.  If the PIN query fails due to a sim busy
> condition, then yes the init process will stall.  This is considered a bug
> in the driver.
>
> got it.

>
>
>>
>>             3) could u explain me what should I really do in virtual fnc
>>               set_online
>>             / post_online ? i tried to stub them but they have not never
>>             been called...
>>
>>
>>         oFono has 3 basic states:
>>         - Off
>>         - Radio Off, Sim On
>>         - Radio On, Sim On
>>
>>         set_online turns radio on / off
>>         post_online populates the atoms that are available in radio 'On'
>>         state.
>>
>>
>> This is what i thought but I do not understand why I don't see the trace
>> log I put inside them...usually are called before pre_sim fn? are
>> related to any signal i have to manage/post ?
>>
>
> enable -> pre_sim, sim_inserted -> post_sim, set_online -> post_online.
>  Generally you do not call set_online before hitting the post_sim state.
>
>
could I don't  implement set_online if I don't need it?



> <snip>
>
>
>
>> I've managing vendor URC for sim detection right now but i have
>> problems.For instance if I remove it when ofonod is ready the Hilonc
>> sends an URC to notify sim status changed but after that it reboots
>> itself(2 sec later)... what i did is to notify the stack that the SIM
>> has been removed and modem is powered off . I thought that after calling
>> set_powered fnc the stack should have called my driver virtual disable
>> function in order to properly close the MUX .. but it's not..
>>
>
> No, if you call ofono_modem_set_powered(modem, FALSE) it assumes that the
> modem powered off due to an internally generated event (e.g. not oFono's
> doing).  The driver has to clean up properly in this case.  The driver
> disable() method is only called on oFono initiated power down requests.
>
>
> mmh ok..so If the modem restarts it's my business to disable and enable
again all the driver' stuff , right?



>
>>
>>             5) I created and started the MUX as the first thing in
>>             enable fnc but is
>>             that right ? sometimes seems that the modem hangs up if just
>>             powered up.
>>             Put a delay but don't like it very much as a
>>             solution...moreover when I
>>             power up the modem all the URC have been lost 'cause the MUX
>>             has not
>>             been created yet..
>>
>>
>>         That is what we do for most devices with a MUX, put it into MUX
>>         state right away after basic initialization.  The devices we
>>         have can be queried for their state in addition to URCs, so it
>>         works out very well.
>>
>> right now i've been using custom URC in the first power up phase to
>> understand modem status. I manually set them but theoretically I should
>> check the values saved on the modem every power cycle. What I was
>> thinking was to test every time the values saved and enabling them if
>> they were not .After that I should call an AT+cfun=3D1,1 in order to res=
et
>> the modem and force it to send me again the needed URCs . What do u think
>> ?
>>
>
> I do not see anything wrong with that strategy.  Just keep in mind that
> querying things you will be resetting (potentially) anyway is likely a
> waste of time.  Only query things that are required for the initialization
> procedure.  For the rest, simply set the setting you want.
>
>
done today and it works.


> Regards,
> -Denis
>

--===============7057713443736802978==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

VG54IGFnYWluIDQgeW91ciBwYXRpZW5jZSBEZW5pcyw8ZGl2Pjxicj48YnI+PGRpdiBjbGFzcz0i
Z21haWxfcXVvdGUiPjIwMTMvMy8yNyBEZW5pcyBLZW56aW9yIDxzcGFuIGRpcj0ibHRyIj4mbHQ7
PGEgaHJlZj0ibWFpbHRvOmRlbmtlbnpAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+ZGVua2Vu
ekBnbWFpbC5jb208L2E+Jmd0Ozwvc3Bhbj48YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1
b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7
cGFkZGluZy1sZWZ0OjFleCI+CkhpIE1hcmNvLDxicj4KPGJyPgombHQ7c25pcCZndDs8ZGl2IGNs
YXNzPSJpbSI+PGJyPgo8YnI+CjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9
Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVm
dDoxZXgiPgqgIKAgoCCgIKAgoCAyKSBpbiBlbmFibGUgZm5jIHRoZSBtb2RlbSBpcyBwb3dlcmVk
IGJ1dCBUaGUgc2ltIGlzIG5vdDxicj4KoCCgIKAgoCCgIKAgcmVhZHkgc288YnI+CqAgoCCgIKAg
oCCgIHNvbWV0aW1lcyBJdCBoYW5ncyB1cC4uLkRvIEkgaGF2ZSB0byB0byBwb2xsIHRoZSBzaW0g
c3RhdHVzPGJyPgqgIKAgoCCgIKAgoCB1bnRpbCBpczxicj4KoCCgIKAgoCCgIKAgcmVhZHkgoCwg
b3IgdGhlIGRyaXZlciB3aWxsIGRvIKB0aGF0IGJ5IGl0c2VsZiA/PGJyPgo8YnI+Cjxicj4KoCCg
IKAgoCBvRm9ubyBuZXZlciBwb2xscyBmb3IgYW55dGhpbmcuIKBJdCBpcyB0aGUgZHJpdmVyJiMz
OTtzPGJyPgqgIKAgoCCgIHJlc3BvbnNpYmlsaXR5IHRvIGRvIHRoYXQgaW4gdGhlIGJlc3QgcG9z
c2libGUgd2F5IGZvciB0aGU8YnI+CqAgoCCgIKAgaGFyZHdhcmUuIKBBbHNvLCBwb3dlcmluZyBv
biB0aGUgbW9kZW0gaXMgc2VwYXJhdGUgZnJvbSB0aGUgc2ltPGJyPgqgIKAgoCCgIGJlaW5nIHJl
YWR5LiCgVGhlIGdlbmVyYWwgZmxvdyBpcyB0aGlzOjxicj4KPGJyPgqgIKAgoCCgIC1FbmFibGUg
bW9kZW08YnI+CqAgoCCgIKAgLVdhaXQgZm9yIHRoZSBtb2RlbSB0byBwb3dlciBvbiBhbmQgdXNl
IG9mb25vX21vZGVtX3NldF9wb3dlcmVkPGJyPgqgIKAgoCCgIHdoZW4gdGhhdCBoYXBwZW5zIHN1
Y2Nlc3NmdWxseSAvIGZhaWxzLjxicj4KoCCgIKAgoCAtIEZpZ3VyZSBvdXQgaWYgdGhlIFNJTSBp
cyBpbnNlcnRlZCBhbmQgc2lnbmFsIHVzaW5nPGJyPgqgIKAgoCCgIG9mb25vX3NpbV9pbnNlcnRl
ZF9ub3RpZnkuIKBEbyB0aGlzIHN0ZXAgb25seSBvbmNlIHRoZSBTSU0gaXM8YnI+CqAgoCCgIKAg
cmVhZHkgdG8gYmUgcXVlcmllZCBmb3IgaXRzIFBJTiBzdGF0dXMgYW5kIHBlcmZvcm0gYW55IEkv
TyBvbjxicj4KoCCgIKAgoCBTSU0gZmlsZXMgdGhhdCBhcmUgYWx3YXlzIGFjY2Vzc2libGUgKGUu
Zy4gSUNDSUQpPGJyPgo8YnI+Cjxicj4KT2suIElmIFNpbSBub3QgJnF1b3Q7cmVhZHkmcXVvdDsg
LCBzZW5kaW5nIGEgc2lnbmFsIHByZW1hdHVyZWx5IGNvdWxkIHN0dWNrIGFueWhvdzxicj4KdGhl
IHN0YWNrID8gJiMzOTtjYXVzZSBpdCBzaG91bGQgZXhwbGFpbiBhIGxvdCBvZiB0aGluZy4uPGJy
Pgo8YnI+CjwvYmxvY2txdW90ZT4KPGJyPjwvZGl2PgpJZiB5b3UgdGVsbCBvRm9ubyBjb3JlIHRo
YXQgdGhlIHNpbSBpcyBpbnNlcnRlZCwgdGhlIGZpcnN0IHRoaW5nIGl0IGRvZXMgaXMgcmVhZCBz
b21lIHNpbSBmaWxlcyB0aGF0IGFyZSBhbHdheXMgYXZhaWxhYmxlLiCgZS5nLiBJQ0NJRCwgZXRj
LiBUaGVuIGl0IHByb2NlZWRzIHRvIGNoZWNrIHRoZSBQSU4uIKBJZiB0aGUgUElOIHF1ZXJ5IGZh
aWxzIGR1ZSB0byBhIHNpbSBidXN5IGNvbmRpdGlvbiwgdGhlbiB5ZXMgdGhlIGluaXQgcHJvY2Vz
cyB3aWxsIHN0YWxsLiCgVGhpcyBpcyBjb25zaWRlcmVkIGEgYnVnIGluIHRoZSBkcml2ZXIuPGRp
diBjbGFzcz0iaW0iPgo8YnI+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+Z290IGl0LqA8L2Rpdj48
YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDti
b3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGNsYXNzPSJp
bSI+Cjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAg
MCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+Cjxi
cj4KPGJyPgqgIKAgoCCgIKAgoCAzKSBjb3VsZCB1IGV4cGxhaW4gbWUgd2hhdCBzaG91bGQgSSBy
ZWFsbHkgZG8gaW4gdmlydHVhbCBmbmM8YnI+CqAgoCCgIKAgoCCgIKAgc2V0X29ubGluZTxicj4K
oCCgIKAgoCCgIKAgLyBwb3N0X29ubGluZSA/IGkgdHJpZWQgdG8gc3R1YiB0aGVtIGJ1dCB0aGV5
IGhhdmUgbm90IG5ldmVyPGJyPgqgIKAgoCCgIKAgoCBiZWVuIGNhbGxlZC4uLjxicj4KPGJyPgo8
YnI+CqAgoCCgIKAgb0Zvbm8gaGFzIDMgYmFzaWMgc3RhdGVzOjxicj4KoCCgIKAgoCAtIE9mZjxi
cj4KoCCgIKAgoCAtIFJhZGlvIE9mZiwgU2ltIE9uPGJyPgqgIKAgoCCgIC0gUmFkaW8gT24sIFNp
bSBPbjxicj4KPGJyPgqgIKAgoCCgIHNldF9vbmxpbmUgdHVybnMgcmFkaW8gb24gLyBvZmY8YnI+
CqAgoCCgIKAgcG9zdF9vbmxpbmUgcG9wdWxhdGVzIHRoZSBhdG9tcyB0aGF0IGFyZSBhdmFpbGFi
bGUgaW4gcmFkaW8gJiMzOTtPbiYjMzk7PGJyPgqgIKAgoCCgIHN0YXRlLjxicj4KPGJyPgo8YnI+
ClRoaXMgaXMgd2hhdCBpIHRob3VnaHQgYnV0IEkgZG8gbm90IHVuZGVyc3RhbmQgd2h5IEkgZG9u
JiMzOTt0IHNlZSB0aGUgdHJhY2U8YnI+CmxvZyBJIHB1dCBpbnNpZGUgdGhlbS4uLnVzdWFsbHkg
YXJlIGNhbGxlZCBiZWZvcmUgcHJlX3NpbSBmbj8gYXJlPGJyPgpyZWxhdGVkIHRvIGFueSBzaWdu
YWwgaSBoYXZlIHRvIG1hbmFnZS9wb3N0ID88YnI+CjwvYmxvY2txdW90ZT4KPGJyPjwvZGl2Pgpl
bmFibGUgLSZndDsgcHJlX3NpbSwgc2ltX2luc2VydGVkIC0mZ3Q7IHBvc3Rfc2ltLCBzZXRfb25s
aW5lIC0mZ3Q7IHBvc3Rfb25saW5lLiCgR2VuZXJhbGx5IHlvdSBkbyBub3QgY2FsbCBzZXRfb25s
aW5lIGJlZm9yZSBoaXR0aW5nIHRoZSBwb3N0X3NpbSBzdGF0ZS48YnI+Cjxicj48L2Jsb2NrcXVv
dGU+PGRpdj48YnI+PC9kaXY+PGRpdj5jb3VsZCBJIGRvbiYjMzk7dCCgaW1wbGVtZW50IHNldF9v
bmxpbmUgaWYgSSBkb24mIzM5O3QgbmVlZCBpdD88L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PqA8
L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAg
LjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KCiZsdDtz
bmlwJmd0OzxkaXYgY2xhc3M9ImltIj48YnI+Cjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWls
X3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29s
aWQ7cGFkZGluZy1sZWZ0OjFleCI+Cjxicj4KSSYjMzk7dmUgbWFuYWdpbmcgdmVuZG9yIFVSQyBm
b3Igc2ltIGRldGVjdGlvbiByaWdodCBub3cgYnV0IGkgaGF2ZTxicj4KcHJvYmxlbXMuRm9yIGlu
c3RhbmNlIGlmIEkgcmVtb3ZlIGl0IHdoZW4gb2Zvbm9kIGlzIHJlYWR5IHRoZSBIaWxvbmM8YnI+
CnNlbmRzIGFuIFVSQyB0byBub3RpZnkgc2ltIHN0YXR1cyBjaGFuZ2VkIGJ1dCBhZnRlciB0aGF0
IGl0IHJlYm9vdHM8YnI+Cml0c2VsZigyIHNlYyBsYXRlcikuLi4gd2hhdCBpIGRpZCBpcyB0byBu
b3RpZnkgdGhlIHN0YWNrIHRoYXQgdGhlIFNJTTxicj4KaGFzIGJlZW4gcmVtb3ZlZCBhbmQgbW9k
ZW0gaXMgcG93ZXJlZCBvZmYgLiBJIHRob3VnaHQgdGhhdCBhZnRlciBjYWxsaW5nPGJyPgpzZXRf
cG93ZXJlZCBmbmMgdGhlIHN0YWNrIHNob3VsZCBoYXZlIGNhbGxlZCBteSBkcml2ZXIgdmlydHVh
bCBkaXNhYmxlPGJyPgpmdW5jdGlvbiBpbiBvcmRlciB0byBwcm9wZXJseSBjbG9zZSB0aGUgTVVY
IC4uIGJ1dCBpdCYjMzk7cyBub3QuLjxicj4KPC9ibG9ja3F1b3RlPgo8YnI+PC9kaXY+Ck5vLCBp
ZiB5b3UgY2FsbCBvZm9ub19tb2RlbV9zZXRfcG93ZXJlZChtb2RlbSwgRkFMU0UpIGl0IGFzc3Vt
ZXMgdGhhdCB0aGUgbW9kZW0gcG93ZXJlZCBvZmYgZHVlIHRvIGFuIGludGVybmFsbHkgZ2VuZXJh
dGVkIGV2ZW50IChlLmcuIG5vdCBvRm9ubyYjMzk7cyBkb2luZykuIKBUaGUgZHJpdmVyIGhhcyB0
byBjbGVhbiB1cCBwcm9wZXJseSBpbiB0aGlzIGNhc2UuIKBUaGUgZHJpdmVyIGRpc2FibGUoKSBt
ZXRob2QgaXMgb25seSBjYWxsZWQgb24gb0Zvbm8gaW5pdGlhdGVkIHBvd2VyIGRvd24gcmVxdWVz
dHMuPGRpdiBjbGFzcz0iaW0iPgo8YnI+Cjxicj48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdj5tbWgg
b2suLnNvIElmIHRoZSBtb2RlbSByZXN0YXJ0cyBpdCYjMzk7cyBteSBidXNpbmVzcyB0byBkaXNh
YmxlIGFuZCBlbmFibGUgYWdhaW4gYWxsIHRoZSBkcml2ZXImIzM5OyBzdHVmZiAsIHJpZ2h0Pzwv
ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+oDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9x
dW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlk
O3BhZGRpbmctbGVmdDoxZXgiPgo8ZGl2IGNsYXNzPSJpbSI+CjxibG9ja3F1b3RlIGNsYXNzPSJn
bWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2Nj
IHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgo8YnI+Cjxicj4KoCCgIKAgoCCgIKAgNSkgSSBjcmVh
dGVkIGFuZCBzdGFydGVkIHRoZSBNVVggYXMgdGhlIGZpcnN0IHRoaW5nIGluPGJyPgqgIKAgoCCg
IKAgoCBlbmFibGUgZm5jIGJ1dCBpczxicj4KoCCgIKAgoCCgIKAgdGhhdCByaWdodCA/IHNvbWV0
aW1lcyBzZWVtcyB0aGF0IHRoZSBtb2RlbSBoYW5ncyB1cCBpZiBqdXN0PGJyPgqgIKAgoCCgIKAg
oCBwb3dlcmVkIHVwLjxicj4KoCCgIKAgoCCgIKAgUHV0IGEgZGVsYXkgYnV0IGRvbiYjMzk7dCBs
aWtlIGl0IHZlcnkgbXVjaCBhcyBhPGJyPgqgIKAgoCCgIKAgoCBzb2x1dGlvbi4uLm1vcmVvdmVy
IHdoZW4gSTxicj4KoCCgIKAgoCCgIKAgcG93ZXIgdXAgdGhlIG1vZGVtIGFsbCB0aGUgVVJDIGhh
dmUgYmVlbiBsb3N0ICYjMzk7Y2F1c2UgdGhlIE1VWDxicj4KoCCgIKAgoCCgIKAgaGFzIG5vdDxi
cj4KoCCgIKAgoCCgIKAgYmVlbiBjcmVhdGVkIHlldC4uPGJyPgo8YnI+Cjxicj4KoCCgIKAgoCBU
aGF0IGlzIHdoYXQgd2UgZG8gZm9yIG1vc3QgZGV2aWNlcyB3aXRoIGEgTVVYLCBwdXQgaXQgaW50
byBNVVg8YnI+CqAgoCCgIKAgc3RhdGUgcmlnaHQgYXdheSBhZnRlciBiYXNpYyBpbml0aWFsaXph
dGlvbi4goFRoZSBkZXZpY2VzIHdlPGJyPgqgIKAgoCCgIGhhdmUgY2FuIGJlIHF1ZXJpZWQgZm9y
IHRoZWlyIHN0YXRlIGluIGFkZGl0aW9uIHRvIFVSQ3MsIHNvIGl0PGJyPgqgIKAgoCCgIHdvcmtz
IG91dCB2ZXJ5IHdlbGwuPGJyPgo8YnI+CnJpZ2h0IG5vdyBpJiMzOTt2ZSBiZWVuIHVzaW5nIGN1
c3RvbSBVUkMgaW4gdGhlIGZpcnN0IHBvd2VyIHVwIHBoYXNlIHRvPGJyPgp1bmRlcnN0YW5kIG1v
ZGVtIHN0YXR1cy4gSSBtYW51YWxseSBzZXQgdGhlbSBidXQgdGhlb3JldGljYWxseSBJIHNob3Vs
ZDxicj4KY2hlY2sgdGhlIHZhbHVlcyBzYXZlZCBvbiB0aGUgbW9kZW0gZXZlcnkgcG93ZXIgY3lj
bGUuIFdoYXQgSSB3YXM8YnI+CnRoaW5raW5nIHdhcyB0byB0ZXN0IGV2ZXJ5IHRpbWUgdGhlIHZh
bHVlcyBzYXZlZCBhbmQgZW5hYmxpbmcgdGhlbSBpZjxicj4KdGhleSB3ZXJlIG5vdCAuQWZ0ZXIg
dGhhdCBJIHNob3VsZCBjYWxsIGFuIEFUK2NmdW49MSwxIGluIG9yZGVyIHRvIHJlc2V0PGJyPgp0
aGUgbW9kZW0gYW5kIGZvcmNlIGl0IHRvIHNlbmQgbWUgYWdhaW4gdGhlIG5lZWRlZCBVUkNzIC4g
V2hhdCBkbyB1IHRoaW5rID88YnI+CjwvYmxvY2txdW90ZT4KPGJyPjwvZGl2PgpJIGRvIG5vdCBz
ZWUgYW55dGhpbmcgd3Jvbmcgd2l0aCB0aGF0IHN0cmF0ZWd5LiCgSnVzdCBrZWVwIGluIG1pbmQg
dGhhdCBxdWVyeWluZyB0aGluZ3MgeW91IHdpbGwgYmUgcmVzZXR0aW5nIChwb3RlbnRpYWxseSkg
YW55d2F5IGlzIGxpa2VseSBhIHdhc3RlIG9mIHRpbWUuIKBPbmx5IHF1ZXJ5IHRoaW5ncyB0aGF0
IGFyZSByZXF1aXJlZCBmb3IgdGhlIGluaXRpYWxpemF0aW9uIHByb2NlZHVyZS4goEZvciB0aGUg
cmVzdCwgc2ltcGx5IHNldCB0aGUgc2V0dGluZyB5b3Ugd2FudC48YnI+Cgo8YnI+PC9ibG9ja3F1
b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+ZG9uZSB0b2RheSBhbmQgaXQgd29ya3MuPC9kaXY+PGRp
dj6gPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAg
MCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+ClJl
Z2FyZHMsPGJyPgotRGVuaXM8YnI+CjwvYmxvY2txdW90ZT48L2Rpdj48YnI+PC9kaXY+Cg==

--===============7057713443736802978==--

