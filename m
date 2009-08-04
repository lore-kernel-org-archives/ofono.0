Content-Type: multipart/mixed; boundary="===============4650106145098426672=="
MIME-Version: 1.0
From: Ceyhun =?unknown-8bit?q?Alye=C5=9Fil?= <ceyhunalyesil@gmail.com>
Subject: Re: How to dismiss incoming call?
Date: Tue, 04 Aug 2009 16:58:48 +0300
Message-ID: <6d1130260908040658y51b2427ay447c843812b0b19d@mail.gmail.com>
In-Reply-To: <4A782F30.70803@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4650106145098426672==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Well its been a long time since i work with mobile fones but there should be
some blockking scripts which just directly reject the call. cant remember
how but if i do i can answer

2009/8/4 Marko Saukko <marko.saukko@gmail.com>

> Hi,
>
> How can I dismiss incoming call without answering to it?
>
> I tried the Busy method, as shown below:
>
> $ sudo dbus-send --system --print-reply --dest=3Dorg.ofono
> /modem1/voicecall01 org.ofono.VoiceCall.Busy
> method return sender=3D:1.277 -> dest=3D:1.284 reply_serial=3D2
>
> Here is what the ofonod prints out:
> ...
> ofonod[2049]: clcc_poll_cb got result: 1
> ofonod[2049]: Final response: OK
> ofonod[2049]: Response line: +CLCC: 1,1,4,0,0,"+358000000000",145
> ofonod[2049]: cring_notify got result: 1
> ofonod[2049]: Final response: (null)
> ofonod[2049]: Response line: +CRING: VOICE
> ofonod[2049]: clip_notify got result: 1
> ofonod[2049]: Final response: (null)
> ofonod[2049]: Response line: +CLIP: "+358000000000",145
> ofonod[2049]: clip_notify: +358000000000 145 0
> ofonod[2049]: Got a voicecall event, status: 4, id: 1, number:
> +358000000000
> ofonod[2049]: Found call with id: 1
> ofonod[2049]: clcc_poll_cb got result: 1
> ofonod[2049]: Final response: OK
> ofonod[2049]: Response line: +CLCC: 1,1,4,0,0,"+358000000000",145
> ...
>
> ...
> ofonod[2049]: generic_cb got result: 1
> ofonod[2049]: Final response: OK
> ...
>
> These messages do not have any effect to the call itself. With E51 the
> only way to dismiss the call in receiving end is to first answer and
> then hangup.
>
> In above tests the Nokia E51 was used (connected with USB cable).
>
>
>
>
> With Nokia 6100 connected with USB cable the the busy method worked
> (call was ended), however the dbus send an error message as a response:
>
> $ sudo dbus-send --system --print-reply --dest=3Dorg.ofono
> /modem1/voicecall01 org.ofono.VoiceCall.Busy
> Error org.freedesktop.DBus.Error.NoReply: Did not receive a reply.
> Possible causes include: the remote application did not send a reply,
> the message bus security policy blocked the reply, the reply timeout
> expired, or the network connection was broken.
>
> And here is the output by ofonod:
>
> ...
> ofonod[1514]: Response line: +CRING: VOICE
> ofonod[1514]: cring_notify
> ofonod[1514]: clip_notify got result: 1
> ofonod[1514]: Final response: (null)
> ofonod[1514]: Response line: +CLIP: "+358000000000",145
> ofonod[1514]: clip_notify: +358000000000 145 0
> ofonod[1514]: Got a voicecall event, status: 4, id: 1, number:
> +358000000000
> ofonod[1514]: Did not find a call with id: 1
> ofonod[1514]: Resetting updating flag
> ofonod[1514]: clcc_poll_cb got result: 0
> ofonod[1514]: Final response: ERROR
> ofonod[1514]: We are polling CLCC and CLCC resulted in an error
> ofonod[1514]: All bets are off for call management
>
>
> after this nothing else was printed even when the busy was sent.
>
>
> oFono version 0.2 was used.
>
>
>
> Regards,
> Marko
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>



-- =

Ceyhun ALYE=C5=9E=C4=B0L

--===============4650106145098426672==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

V2VsbCBpdHMgYmVlbiBhIGxvbmcgdGltZSBzaW5jZSBpIHdvcmsgd2l0aCBtb2JpbGUgZm9uZXMg
YnV0IHRoZXJlIHNob3VsZCBiZSBzb21lIGJsb2Nra2luZyBzY3JpcHRzIHdoaWNoIGp1c3QgZGly
ZWN0bHkgcmVqZWN0IHRoZSBjYWxsLiBjYW50IHJlbWVtYmVyIGhvdyBidXQgaWYgaSBkbyBpIGNh
biBhbnN3ZXI8YnI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj4yMDA5LzgvNCBNYXJrbyBT
YXVra28gPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86bWFya28uc2F1a2tvQGdt
YWlsLmNvbSI+bWFya28uc2F1a2tvQGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFuPjxicj4KPGJsb2Nr
cXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0iYm9yZGVyLWxlZnQ6IDFweCBzb2xpZCBy
Z2IoMjA0LCAyMDQsIDIwNCk7IG1hcmdpbjogMHB0IDBwdCAwcHQgMC44ZXg7IHBhZGRpbmctbGVm
dDogMWV4OyI+SGksPGJyPgo8YnI+CkhvdyBjYW4gSSBkaXNtaXNzIGluY29taW5nIGNhbGwgd2l0
aG91dCBhbnN3ZXJpbmcgdG8gaXQ/PGJyPgo8YnI+CkkgdHJpZWQgdGhlIEJ1c3kgbWV0aG9kLCBh
cyBzaG93biBiZWxvdzo8YnI+Cjxicj4KJCBzdWRvIGRidXMtc2VuZCAtLXN5c3RlbSAtLXByaW50
LXJlcGx5IC0tZGVzdD1vcmcub2Zvbm88YnI+Ci9tb2RlbTEvdm9pY2VjYWxsMDEgb3JnLm9mb25v
LlZvaWNlQ2FsbC5CdXN5PGJyPgptZXRob2QgcmV0dXJuIHNlbmRlcj06MS4yNzcgLSZndDsgZGVz
dD06MS4yODQgcmVwbHlfc2VyaWFsPTI8YnI+Cjxicj4KSGVyZSBpcyB3aGF0IHRoZSBvZm9ub2Qg
cHJpbnRzIG91dDo8YnI+Ci4uLjxicj4Kb2Zvbm9kWzIwNDldOiBjbGNjX3BvbGxfY2IgZ290IHJl
c3VsdDogMTxicj4Kb2Zvbm9kWzIwNDldOiBGaW5hbCByZXNwb25zZTogT0s8YnI+Cm9mb25vZFsy
MDQ5XTogUmVzcG9uc2UgbGluZTogK0NMQ0M6IDEsMSw0LDAsMCwmcXVvdDsrMzU4MDAwMDAwMDAw
JnF1b3Q7LDE0NTxicj4Kb2Zvbm9kWzIwNDldOiBjcmluZ19ub3RpZnkgZ290IHJlc3VsdDogMTxi
cj4Kb2Zvbm9kWzIwNDldOiBGaW5hbCByZXNwb25zZTogKG51bGwpPGJyPgpvZm9ub2RbMjA0OV06
IFJlc3BvbnNlIGxpbmU6ICtDUklORzogVk9JQ0U8YnI+Cm9mb25vZFsyMDQ5XTogY2xpcF9ub3Rp
ZnkgZ290IHJlc3VsdDogMTxicj4Kb2Zvbm9kWzIwNDldOiBGaW5hbCByZXNwb25zZTogKG51bGwp
PGJyPgpvZm9ub2RbMjA0OV06IFJlc3BvbnNlIGxpbmU6ICtDTElQOiAmcXVvdDsrMzU4MDAwMDAw
MDAwJnF1b3Q7LDE0NTxicj4Kb2Zvbm9kWzIwNDldOiBjbGlwX25vdGlmeTogKzM1ODAwMDAwMDAw
MCAxNDUgMDxicj4Kb2Zvbm9kWzIwNDldOiBHb3QgYSB2b2ljZWNhbGwgZXZlbnQsIHN0YXR1czog
NCwgaWQ6IDEsIG51bWJlcjogKzM1ODAwMDAwMDAwMDxicj4Kb2Zvbm9kWzIwNDldOiBGb3VuZCBj
YWxsIHdpdGggaWQ6IDE8YnI+Cm9mb25vZFsyMDQ5XTogY2xjY19wb2xsX2NiIGdvdCByZXN1bHQ6
IDE8YnI+Cm9mb25vZFsyMDQ5XTogRmluYWwgcmVzcG9uc2U6IE9LPGJyPgpvZm9ub2RbMjA0OV06
IFJlc3BvbnNlIGxpbmU6ICtDTENDOiAxLDEsNCwwLDAsJnF1b3Q7KzM1ODAwMDAwMDAwMCZxdW90
OywxNDU8YnI+Ci4uLjxicj4KPGJyPgouLi48YnI+Cm9mb25vZFsyMDQ5XTogZ2VuZXJpY19jYiBn
b3QgcmVzdWx0OiAxPGJyPgpvZm9ub2RbMjA0OV06IEZpbmFsIHJlc3BvbnNlOiBPSzxicj4KLi4u
PGJyPgo8YnI+ClRoZXNlIG1lc3NhZ2VzIGRvIG5vdCBoYXZlIGFueSBlZmZlY3QgdG8gdGhlIGNh
bGwgaXRzZWxmLiBXaXRoIEU1MSB0aGU8YnI+Cm9ubHkgd2F5IHRvIGRpc21pc3MgdGhlIGNhbGwg
aW4gcmVjZWl2aW5nIGVuZCBpcyB0byBmaXJzdCBhbnN3ZXIgYW5kPGJyPgp0aGVuIGhhbmd1cC48
YnI+Cjxicj4KSW4gYWJvdmUgdGVzdHMgdGhlIE5va2lhIEU1MSB3YXMgdXNlZCAoY29ubmVjdGVk
IHdpdGggVVNCIGNhYmxlKS48YnI+Cjxicj4KPGJyPgo8YnI+Cjxicj4KV2l0aCBOb2tpYSA2MTAw
IGNvbm5lY3RlZCB3aXRoIFVTQiBjYWJsZSB0aGUgdGhlIGJ1c3kgbWV0aG9kIHdvcmtlZDxicj4K
KGNhbGwgd2FzIGVuZGVkKSwgaG93ZXZlciB0aGUgZGJ1cyBzZW5kIGFuIGVycm9yIG1lc3NhZ2Ug
YXMgYSByZXNwb25zZTo8YnI+Cjxicj4KJCBzdWRvIGRidXMtc2VuZCAtLXN5c3RlbSAtLXByaW50
LXJlcGx5IC0tZGVzdD1vcmcub2Zvbm88YnI+Ci9tb2RlbTEvdm9pY2VjYWxsMDEgb3JnLm9mb25v
LlZvaWNlQ2FsbC5CdXN5PGJyPgpFcnJvciBvcmcuZnJlZWRlc2t0b3AuREJ1cy5FcnJvci5Ob1Jl
cGx5OiBEaWQgbm90IHJlY2VpdmUgYSByZXBseS48YnI+ClBvc3NpYmxlIGNhdXNlcyBpbmNsdWRl
OiB0aGUgcmVtb3RlIGFwcGxpY2F0aW9uIGRpZCBub3Qgc2VuZCBhIHJlcGx5LDxicj4KdGhlIG1l
c3NhZ2UgYnVzIHNlY3VyaXR5IHBvbGljeSBibG9ja2VkIHRoZSByZXBseSwgdGhlIHJlcGx5IHRp
bWVvdXQ8YnI+CmV4cGlyZWQsIG9yIHRoZSBuZXR3b3JrIGNvbm5lY3Rpb24gd2FzIGJyb2tlbi48
YnI+Cjxicj4KQW5kIGhlcmUgaXMgdGhlIG91dHB1dCBieSBvZm9ub2Q6PGJyPgo8YnI+Ci4uLjxi
cj4Kb2Zvbm9kWzE1MTRdOiBSZXNwb25zZSBsaW5lOiArQ1JJTkc6IFZPSUNFPGJyPgpvZm9ub2Rb
MTUxNF06IGNyaW5nX25vdGlmeTxicj4Kb2Zvbm9kWzE1MTRdOiBjbGlwX25vdGlmeSBnb3QgcmVz
dWx0OiAxPGJyPgpvZm9ub2RbMTUxNF06IEZpbmFsIHJlc3BvbnNlOiAobnVsbCk8YnI+Cm9mb25v
ZFsxNTE0XTogUmVzcG9uc2UgbGluZTogK0NMSVA6ICZxdW90OyszNTgwMDAwMDAwMDAmcXVvdDss
MTQ1PGJyPgpvZm9ub2RbMTUxNF06IGNsaXBfbm90aWZ5OiArMzU4MDAwMDAwMDAwIDE0NSAwPGJy
PgpvZm9ub2RbMTUxNF06IEdvdCBhIHZvaWNlY2FsbCBldmVudCwgc3RhdHVzOiA0LCBpZDogMSwg
bnVtYmVyOiArMzU4MDAwMDAwMDAwPGJyPgpvZm9ub2RbMTUxNF06IERpZCBub3QgZmluZCBhIGNh
bGwgd2l0aCBpZDogMTxicj4Kb2Zvbm9kWzE1MTRdOiBSZXNldHRpbmcgdXBkYXRpbmcgZmxhZzxi
cj4Kb2Zvbm9kWzE1MTRdOiBjbGNjX3BvbGxfY2IgZ290IHJlc3VsdDogMDxicj4Kb2Zvbm9kWzE1
MTRdOiBGaW5hbCByZXNwb25zZTogRVJST1I8YnI+Cm9mb25vZFsxNTE0XTogV2UgYXJlIHBvbGxp
bmcgQ0xDQyBhbmQgQ0xDQyByZXN1bHRlZCBpbiBhbiBlcnJvcjxicj4Kb2Zvbm9kWzE1MTRdOiBB
bGwgYmV0cyBhcmUgb2ZmIGZvciBjYWxsIG1hbmFnZW1lbnQ8YnI+Cjxicj4KPGJyPgphZnRlciB0
aGlzIG5vdGhpbmcgZWxzZSB3YXMgcHJpbnRlZCBldmVuIHdoZW4gdGhlIGJ1c3kgd2FzIHNlbnQu
PGJyPgo8YnI+Cjxicj4Kb0Zvbm8gdmVyc2lvbiAwLjIgd2FzIHVzZWQuPGJyPgo8YnI+Cjxicj4K
PGJyPgpSZWdhcmRzLDxicj4KTWFya288YnI+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fPGJyPgpvZm9ubyBtYWlsaW5nIGxpc3Q8YnI+CjxhIGhyZWY9Im1h
aWx0bzpvZm9ub0BvZm9uby5vcmciPm9mb25vQG9mb25vLm9yZzwvYT48YnI+CjxhIGhyZWY9Imh0
dHA6Ly9saXN0cy5vZm9uby5vcmcvbGlzdGluZm8vb2Zvbm8iIHRhcmdldD0iX2JsYW5rIj5odHRw
Oi8vbGlzdHMub2Zvbm8ub3JnL2xpc3RpbmZvL29mb25vPC9hPjxicj4KPC9ibG9ja3F1b3RlPjwv
ZGl2Pjxicj48YnIgY2xlYXI9ImFsbCI+PGJyPi0tIDxicj5DZXlodW4gQUxZRcWexLBMPGJyPgo=

--===============4650106145098426672==--

