Content-Type: multipart/mixed; boundary="===============1427708387425890741=="
MIME-Version: 1.0
From: Renat Zaripov <r.r.zaripov@gmail.com>
Subject: Re: SIMCOM support
Date: Fri, 25 Jan 2013 13:01:46 +0400
Message-ID: <CAGNC_aOxrFmWgwE3Mc-8=XypVr-BLtPhN966gCwsj_73O-+XBg@mail.gmail.com>
In-Reply-To: <51017BC4.4000004@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1427708387425890741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2013/1/24 Denis Kenzior

> Hi Anthony,
>
> On 01/24/2013 11:13 AM, Viallard Anthony wrote:
>
>> On 24. 01. 13 17:21, Denis Kenzior wrote:
>>
>>  How closely related is this one to SIMCOM 900? We already do have a
>>> plugin for it in the tree, so it might be a good idea to merge the two
>>> if they are closely related.
>>>
>>
In near time I'll begin rework  plugin for SIM900 . I'll want replace
external cmux with the  internal oFono  gatmux, and add GPRS. But I think
merge is possible. Only one question is actual to me - we use voice calls
in SIM900, and during merge this functionality must be saved.


>
>> I don't known if SIM900 works with my driver plugin. SIMCOM were not
>> given us this information whereas we inquired them. It will be glad if
>> someone check it.
>>
>
Ok, I can check your plugin with SIM900 in near time.


>
>> The only main difference i see between the two plugins, it's the
>> AT+CSCS=3D"GSM" command. I don't exactly why there is this command. Maybe
>> its a behavior need it to work correctly with the operator where the guy
>> has wrote the code and done the test. If someone tell me how to check
>> (with an AT command ?) if we need this command, I will do the job.
>>
>>
> If this is the only difference then the two plugins should be merged. Any
> minor variations can be taken care of by checking the model / firmware
> versions.
>
> The CSCS command is used to set the character set.  It is mostly used to
> make sure basic strings from the modem will be in a format we recognize
> (e.g. phone numbers, operator names, etc).  This setting should generally
> be safe.
>

From SIM900 AT command manual:
"The SIM900 AT Command interface defaults to the IRA character set.", so we
use AT+CSCS=3D"GSM" for compatibility with settings of our provider.


>  * I would like to do a reset of the modem at start and at end of ofono
>>>> life (with AT+CFUN=3D6 or AT+CRESET). The purpose is having a modem al=
ways
>>>> in init state for ofono and the others programs. Do you think its a go=
od
>>>> idea ?
>>>>
>>>>
>>> In general that is not desirable. The modem should be initialized when
>>> the enable driver method is called. Why do you want to do this?
>>>
>>
>> I guessed it will be nicer to have this but if you say no, ok, it was
>> just an idea to have always a chips in same state at start and when
>> ofono stops.
>>
>>
> The chip should be powered down in disable(), so in theory it will be in
> the same state prior to oFono starting.  Maybe I'm mis-understanding what
> you're trying to do.
>
> Regards,
> -Denis
> ______________________________**_________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/**listinfo/ofono<http://lists.ofono.org/listinfo/o=
fono>
>

Best regards,
Renat Zaripov

--===============1427708387425890741==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgRGVuaXMsPGRpdj48YnI+PC9kaXY+PGRpdj4yMDEzLzEvMjQgRGVu
aXMgS2Vuemlvcjxicj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGRpdiBjbGFzcz0iZ21haWxf
cXVvdGUiPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHgg
MHB4IDBweCAwLjhleDtib3JkZXItbGVmdC13aWR0aDoxcHg7Ym9yZGVyLWxlZnQtY29sb3I6cmdi
KDIwNCwyMDQsMjA0KTtib3JkZXItbGVmdC1zdHlsZTpzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4K
CgoKSGkgQW50aG9ueSw8YnI+Cjxicj4KT24gMDEvMjQvMjAxMyAxMToxMyBBTSwgVmlhbGxhcmQg
QW50aG9ueSB3cm90ZTo8YnI+CjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9
Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdC13aWR0aDoxcHg7Ym9yZGVyLWxl
ZnQtY29sb3I6cmdiKDIwNCwyMDQsMjA0KTtib3JkZXItbGVmdC1zdHlsZTpzb2xpZDtwYWRkaW5n
LWxlZnQ6MWV4Ij4KT24gMjQuIDAxLiAxMyAxNzoyMSwgRGVuaXMgS2VuemlvciB3cm90ZTo8YnI+
Cjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAw
cHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0LXdpZHRoOjFweDtib3JkZXItbGVmdC1jb2xvcjpyZ2Io
MjA0LDIwNCwyMDQpO2JvcmRlci1sZWZ0LXN0eWxlOnNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgpI
b3cgY2xvc2VseSByZWxhdGVkIGlzIHRoaXMgb25lIHRvIFNJTUNPTSA5MDA/IFdlIGFscmVhZHkg
ZG8gaGF2ZSBhPGJyPgpwbHVnaW4gZm9yIGl0IGluIHRoZSB0cmVlLCBzbyBpdCBtaWdodCBiZSBh
IGdvb2QgaWRlYSB0byBtZXJnZSB0aGUgdHdvPGJyPgppZiB0aGV5IGFyZSBjbG9zZWx5IHJlbGF0
ZWQuPGJyPjwvYmxvY2txdW90ZT48L2Jsb2NrcXVvdGU+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwv
ZGl2PjxkaXYgc3R5bGU+SW4gbmVhciB0aW1lIEkmIzM5O2xsIGJlZ2luIHJld29yayCgcGx1Z2lu
IGZvciBTSU05MDAgLiBJJiMzOTtsbCB3YW50IHJlcGxhY2UgZXh0ZXJuYWwgY211eCB3aXRoIHRo
ZSCgaW50ZXJuYWwgb0Zvbm8goGdhdG11eCwgYW5kIGFkZCBHUFJTLiBCdXQgSSB0aGluayBtZXJn
ZSBpcyBwb3NzaWJsZS4gT25seSBvbmUgcXVlc3Rpb24gaXMgYWN0dWFsIHRvIG1lIC0gd2UgdXNl
IHZvaWNlIGNhbGxzIGluIFNJTTkwMCwgYW5kIGR1cmluZyBtZXJnZSB0aGlzIGZ1bmN0aW9uYWxp
dHkgbXVzdCBiZSBzYXZlZC48L2Rpdj4KCjxkaXY+oDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJn
bWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdC13
aWR0aDoxcHg7Ym9yZGVyLWxlZnQtY29sb3I6cmdiKDIwNCwyMDQsMjA0KTtib3JkZXItbGVmdC1z
dHlsZTpzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1
b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0LXdpZHRoOjFw
eDtib3JkZXItbGVmdC1jb2xvcjpyZ2IoMjA0LDIwNCwyMDQpO2JvcmRlci1sZWZ0LXN0eWxlOnNv
bGlkO3BhZGRpbmctbGVmdDoxZXgiPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5
bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdC13aWR0aDoxcHg7Ym9yZGVy
LWxlZnQtY29sb3I6cmdiKDIwNCwyMDQsMjA0KTtib3JkZXItbGVmdC1zdHlsZTpzb2xpZDtwYWRk
aW5nLWxlZnQ6MWV4Ij4KCgoKPC9ibG9ja3F1b3RlPgo8YnI+CkkgZG9uJiMzOTt0IGtub3duIGlm
IFNJTTkwMCB3b3JrcyB3aXRoIG15IGRyaXZlciBwbHVnaW4uIFNJTUNPTSB3ZXJlIG5vdDxicj4K
Z2l2ZW4gdXMgdGhpcyBpbmZvcm1hdGlvbiB3aGVyZWFzIHdlIGlucXVpcmVkIHRoZW0uIEl0IHdp
bGwgYmUgZ2xhZCBpZjxicj4Kc29tZW9uZSBjaGVjayBpdC48YnI+PC9ibG9ja3F1b3RlPjwvYmxv
Y2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2Pk9rLCBJIGNhbiBjaGVjayB5b3VyIHBsdWdpbiB3
aXRoIFNJTTkwMCBpbiBuZWFyIHRpbWUuPC9kaXY+PGRpdj6gPC9kaXY+PGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1s
ZWZ0LXdpZHRoOjFweDtib3JkZXItbGVmdC1jb2xvcjpyZ2IoMjA0LDIwNCwyMDQpO2JvcmRlci1s
ZWZ0LXN0eWxlOnNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgoKCjxibG9ja3F1b3RlIGNsYXNzPSJn
bWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdC13
aWR0aDoxcHg7Ym9yZGVyLWxlZnQtY29sb3I6cmdiKDIwNCwyMDQsMjA0KTtib3JkZXItbGVmdC1z
dHlsZTpzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KPGJyPgpUaGUgb25seSBtYWluIGRpZmZlcmVu
Y2UgaSBzZWUgYmV0d2VlbiB0aGUgdHdvIHBsdWdpbnMsIGl0JiMzOTtzIHRoZTxicj4KQVQrQ1ND
Uz0mcXVvdDtHU00mcXVvdDsgY29tbWFuZC4gSSBkb24mIzM5O3QgZXhhY3RseSB3aHkgdGhlcmUg
aXMgdGhpcyBjb21tYW5kLiBNYXliZTxicj4KaXRzIGEgYmVoYXZpb3IgbmVlZCBpdCB0byB3b3Jr
IGNvcnJlY3RseSB3aXRoIHRoZSBvcGVyYXRvciB3aGVyZSB0aGUgZ3V5PGJyPgpoYXMgd3JvdGUg
dGhlIGNvZGUgYW5kIGRvbmUgdGhlIHRlc3QuIElmIHNvbWVvbmUgdGVsbCBtZSBob3cgdG8gY2hl
Y2s8YnI+Cih3aXRoIGFuIEFUIGNvbW1hbmQgPykgaWYgd2UgbmVlZCB0aGlzIGNvbW1hbmQsIEkg
d2lsbCBkbyB0aGUgam9iLjxicj4KPGJyPgo8L2Jsb2NrcXVvdGU+Cjxicj4KSWYgdGhpcyBpcyB0
aGUgb25seSBkaWZmZXJlbmNlIHRoZW4gdGhlIHR3byBwbHVnaW5zIHNob3VsZCBiZSBtZXJnZWQu
IEFueSBtaW5vciB2YXJpYXRpb25zIGNhbiBiZSB0YWtlbiBjYXJlIG9mIGJ5IGNoZWNraW5nIHRo
ZSBtb2RlbCAvIGZpcm13YXJlIHZlcnNpb25zLjxicj4KPGJyPgpUaGUgQ1NDUyBjb21tYW5kIGlz
IHVzZWQgdG8gc2V0IHRoZSBjaGFyYWN0ZXIgc2V0LiCgSXQgaXMgbW9zdGx5IHVzZWQgdG8gbWFr
ZSBzdXJlIGJhc2ljIHN0cmluZ3MgZnJvbSB0aGUgbW9kZW0gd2lsbCBiZSBpbiBhIGZvcm1hdCB3
ZSByZWNvZ25pemUgKGUuZy4gcGhvbmUgbnVtYmVycywgb3BlcmF0b3IgbmFtZXMsIGV0YykuIKBU
aGlzIHNldHRpbmcgc2hvdWxkIGdlbmVyYWxseSBiZSBzYWZlLjxicj4KCgoKPC9ibG9ja3F1b3Rl
PjxkaXY+PGJyPjwvZGl2PjxkaXY+RnJvbSBTSU05MDAgQVQgY29tbWFuZCBtYW51YWw6PC9kaXY+
PGRpdj4mcXVvdDtUaGUgU0lNOTAwIEFUIENvbW1hbmQgaW50ZXJmYWNlIGRlZmF1bHRzIHRvIHRo
ZSBJUkEgY2hhcmFjdGVyIHNldC4mcXVvdDssIHNvIHdlIHVzZSBBVCtDU0NTPSZxdW90O0dTTSZx
dW90OyBmb3IgY29tcGF0aWJpbGl0eSB3aXRoIHNldHRpbmdzIG9mIG91ciBwcm92aWRlci48YnI+
CgoKPC9kaXY+PGRpdj6gPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHls
ZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0LXdpZHRoOjFweDtib3JkZXIt
bGVmdC1jb2xvcjpyZ2IoMjA0LDIwNCwyMDQpO2JvcmRlci1sZWZ0LXN0eWxlOnNvbGlkO3BhZGRp
bmctbGVmdDoxZXgiPgoKPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFy
Z2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0LXdpZHRoOjFweDtib3JkZXItbGVmdC1j
b2xvcjpyZ2IoMjA0LDIwNCwyMDQpO2JvcmRlci1sZWZ0LXN0eWxlOnNvbGlkO3BhZGRpbmctbGVm
dDoxZXgiPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHgg
MHB4IDBweCAwLjhleDtib3JkZXItbGVmdC13aWR0aDoxcHg7Ym9yZGVyLWxlZnQtY29sb3I6cmdi
KDIwNCwyMDQsMjA0KTtib3JkZXItbGVmdC1zdHlsZTpzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4K
CgoKPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHgg
MHB4IDAuOGV4O2JvcmRlci1sZWZ0LXdpZHRoOjFweDtib3JkZXItbGVmdC1jb2xvcjpyZ2IoMjA0
LDIwNCwyMDQpO2JvcmRlci1sZWZ0LXN0eWxlOnNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgoqIEkg
d291bGQgbGlrZSB0byBkbyBhIHJlc2V0IG9mIHRoZSBtb2RlbSBhdCBzdGFydCBhbmQgYXQgZW5k
IG9mIG9mb25vPGJyPgpsaWZlICh3aXRoIEFUK0NGVU49NiBvciBBVCtDUkVTRVQpLiBUaGUgcHVy
cG9zZSBpcyBoYXZpbmcgYSBtb2RlbSBhbHdheXM8YnI+CmluIGluaXQgc3RhdGUgZm9yIG9mb25v
IGFuZCB0aGUgb3RoZXJzIHByb2dyYW1zLiBEbyB5b3UgdGhpbmsgaXRzIGEgZ29vZDxicj4KaWRl
YSA/PGJyPgo8YnI+CjwvYmxvY2txdW90ZT4KPGJyPgpJbiBnZW5lcmFsIHRoYXQgaXMgbm90IGRl
c2lyYWJsZS4gVGhlIG1vZGVtIHNob3VsZCBiZSBpbml0aWFsaXplZCB3aGVuPGJyPgp0aGUgZW5h
YmxlIGRyaXZlciBtZXRob2QgaXMgY2FsbGVkLiBXaHkgZG8geW91IHdhbnQgdG8gZG8gdGhpcz88
YnI+CjwvYmxvY2txdW90ZT4KPGJyPgpJIGd1ZXNzZWQgaXQgd2lsbCBiZSBuaWNlciB0byBoYXZl
IHRoaXMgYnV0IGlmIHlvdSBzYXkgbm8sIG9rLCBpdCB3YXM8YnI+Cmp1c3QgYW4gaWRlYSB0byBo
YXZlIGFsd2F5cyBhIGNoaXBzIGluIHNhbWUgc3RhdGUgYXQgc3RhcnQgYW5kIHdoZW48YnI+Cm9m
b25vIHN0b3BzLjxicj4KPGJyPgo8L2Jsb2NrcXVvdGU+Cjxicj4KVGhlIGNoaXAgc2hvdWxkIGJl
IHBvd2VyZWQgZG93biBpbiBkaXNhYmxlKCksIHNvIGluIHRoZW9yeSBpdCB3aWxsIGJlIGluIHRo
ZSBzYW1lIHN0YXRlIHByaW9yIHRvIG9Gb25vIHN0YXJ0aW5nLiCgTWF5YmUgSSYjMzk7bSBtaXMt
dW5kZXJzdGFuZGluZyB3aGF0IHlvdSYjMzk7cmUgdHJ5aW5nIHRvIGRvLjxicj4KPGJyPgpSZWdh
cmRzLDxicj4KLURlbmlzPGJyPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX188dT48L3U+
X19fX19fX19fX19fX19fX188YnI+Cm9mb25vIG1haWxpbmcgbGlzdDxicj4KPGEgaHJlZj0ibWFp
bHRvOm9mb25vQG9mb25vLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPm9mb25vQG9mb25vLm9yZzwvYT48
YnI+CjxhIGhyZWY9Imh0dHA6Ly9saXN0cy5vZm9uby5vcmcvbGlzdGluZm8vb2Zvbm8iIHRhcmdl
dD0iX2JsYW5rIj5odHRwOi8vbGlzdHMub2Zvbm8ub3JnLzx1PjwvdT5saXN0aW5mby9vZm9ubzwv
YT48YnI+CjwvYmxvY2txdW90ZT48L2Rpdj48YnI+PC9kaXY+PC9kaXY+PGRpdiBjbGFzcz0iZ21h
aWxfZXh0cmEiIHN0eWxlPkJlc3QgcmVnYXJkcyw8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRy
YSIgc3R5bGU+UmVuYXQgWmFyaXBvdjwvZGl2PjwvZGl2Pgo=

--===============1427708387425890741==--

