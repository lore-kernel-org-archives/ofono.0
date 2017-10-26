Content-Type: multipart/mixed; boundary="===============5451847367986429456=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: Re: AW: Ofono 1.21 crashes with Sierra MC7455
Date: Thu, 26 Oct 2017 13:58:58 +0200
Message-ID: <ed1a0e7a-1a0b-a347-a5a5-59c521c6d400@kerlink.fr>
In-Reply-To: <bb1f1944-c187-200b-e545-6fe532f83b6d@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5451847367986429456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I make a quick review, use checkpatch and post it.

Thanks for testing and sorry to not always take the time needed to =

propose a patch to mainline.


Christophe


On 10/26/2017 12:54 PM, Jonas Bonn wrote:
> On 10/26/2017 12:43 PM, Christophe Ronco wrote:
>>
>>
>>> Seems to be this:
>>>
>>> i)=C2=A0 When the modem is first powered on, service discovery takes so=
me =

>>> time (more than 5 seconds)
>>> ii)=C2=A0 The service discovery timeout fires before the QMI request =

>>> returns so discover_reply gets called before discover_callback and =

>>> things get cleaned up
>>> iii)=C2=A0 Then the QMI request returns and discover_callback gets call=
ed =

>>> even though the request has timed out in ii)
>>>
>>> ...and this is where things go wrong because the userdata pointer to =

>>> discover_callback is probably no longer valid.
>>>
>>> How do we handle the QMI request returning a _late_ response, i.e. =

>>> after it technically has timed out?=C2=A0 I'll dig a bit more...
>>>
>>> /Jonas
>>
>> Hi Jonas,
>>
>> When I look at my personal patches, it seems I've already seen that. =

>> Please find attached the patch I currently have in my setup on this =

>> subject.
>>
>
> Yes, that's exactly what I was just in the process of implementing.=C2=A0 =

> Glad you beat me to it.=C2=A0 :)
>
> I tested your patch and it solves the problem.=C2=A0 Can you submit it to =

> the list?=C2=A0 If not, I will... :)
>
> I think service_create_reply() has the same issue but I don't hit it =

> in my setup..
>
> Eswaran:=C2=A0 try the patch from Christophe... I'm 99% certain it solves =

> your issue.
>
> /Jonas
>
>> Christophe
>>
>>
>>
>>
>>
>>
>> _______________________________________________
>> ofono mailing list
>> ofono(a)ofono.org
>> https://lists.ofono.org/mailman/listinfo/ofono
>
>
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono


--===============5451847367986429456==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRl
bnQ9InRleHQvaHRtbDsKICAgICAgY2hhcnNldD13aW5kb3dzLTEyNTIiPgogIDwvaGVhZD4KICA8
Ym9keSB0ZXh0PSIjMDAwMDAwIiBiZ2NvbG9yPSIjRkZGRkZGIj4KICAgIDxwPkkgbWFrZSBhIHF1
aWNrIHJldmlldywgdXNlIGNoZWNrcGF0Y2ggYW5kIHBvc3QgaXQuPC9wPgogICAgPHA+VGhhbmtz
IGZvciB0ZXN0aW5nIGFuZCBzb3JyeSB0byBub3QgYWx3YXlzIHRha2UgdGhlIHRpbWUgbmVlZGVk
CiAgICAgIHRvIHByb3Bvc2UgYSBwYXRjaCB0byBtYWlubGluZS48L3A+CiAgICA8cD48YnI+CiAg
ICA8L3A+CiAgICA8cD5DaHJpc3RvcGhlPGJyPgogICAgPC9wPgogICAgPGJyPgogICAgPGRpdiBj
bGFzcz0ibW96LWNpdGUtcHJlZml4Ij5PbiAxMC8yNi8yMDE3IDEyOjU0IFBNLCBKb25hcyBCb25u
CiAgICAgIHdyb3RlOjxicj4KICAgIDwvZGl2PgogICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIK
ICAgICAgY2l0ZT0ibWlkOmJiMWYxOTQ0LWMxODctMjAwYi1lNTQ1LTZmZTUzMmY4M2I2ZEBzb3V0
aHBvbGUuc2UiPgogICAgICA8bWV0YSBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9d2luZG93
cy0xMjUyIgogICAgICAgIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSI+CiAgICAgIDxkaXYgY2xh
c3M9Im1vei1jaXRlLXByZWZpeCI+T24gMTAvMjYvMjAxNyAxMjo0MyBQTSwgQ2hyaXN0b3BoZQog
ICAgICAgIFJvbmNvIHdyb3RlOjxicj4KICAgICAgPC9kaXY+CiAgICAgIDxibG9ja3F1b3RlCiAg
ICAgICAgY2l0ZT0ibWlkOmJhOWM5ZTc4LWMzZjYtYTc4NC1iYTgzLTQ3MzU3ZDAyOWMxOEBrZXJs
aW5rLmZyIgogICAgICAgIHR5cGU9ImNpdGUiPiA8YnI+CiAgICAgICAgPGJyPgogICAgICAgIDxi
bG9ja3F1b3RlIHR5cGU9ImNpdGUiPlNlZW1zIHRvIGJlIHRoaXM6IDxicj4KICAgICAgICAgIDxi
cj4KICAgICAgICAgIGkpoCBXaGVuIHRoZSBtb2RlbSBpcyBmaXJzdCBwb3dlcmVkIG9uLCBzZXJ2
aWNlIGRpc2NvdmVyeQogICAgICAgICAgdGFrZXMgc29tZSB0aW1lIChtb3JlIHRoYW4gNSBzZWNv
bmRzKSA8YnI+CiAgICAgICAgICBpaSmgIFRoZSBzZXJ2aWNlIGRpc2NvdmVyeSB0aW1lb3V0IGZp
cmVzIGJlZm9yZSB0aGUgUU1JCiAgICAgICAgICByZXF1ZXN0IHJldHVybnMgc28gZGlzY292ZXJf
cmVwbHkgZ2V0cyBjYWxsZWQgYmVmb3JlCiAgICAgICAgICBkaXNjb3Zlcl9jYWxsYmFjayBhbmQg
dGhpbmdzIGdldCBjbGVhbmVkIHVwIDxicj4KICAgICAgICAgIGlpaSmgIFRoZW4gdGhlIFFNSSBy
ZXF1ZXN0IHJldHVybnMgYW5kIGRpc2NvdmVyX2NhbGxiYWNrIGdldHMKICAgICAgICAgIGNhbGxl
ZCBldmVuIHRob3VnaCB0aGUgcmVxdWVzdCBoYXMgdGltZWQgb3V0IGluIGlpKSA8YnI+CiAgICAg
ICAgICA8YnI+CiAgICAgICAgICAuLi5hbmQgdGhpcyBpcyB3aGVyZSB0aGluZ3MgZ28gd3Jvbmcg
YmVjYXVzZSB0aGUgdXNlcmRhdGEKICAgICAgICAgIHBvaW50ZXIgdG8gZGlzY292ZXJfY2FsbGJh
Y2sgaXMgcHJvYmFibHkgbm8gbG9uZ2VyIHZhbGlkLiA8YnI+CiAgICAgICAgICA8YnI+CiAgICAg
ICAgICBIb3cgZG8gd2UgaGFuZGxlIHRoZSBRTUkgcmVxdWVzdCByZXR1cm5pbmcgYSBfbGF0ZV8g
cmVzcG9uc2UsCiAgICAgICAgICBpLmUuIGFmdGVyIGl0IHRlY2huaWNhbGx5IGhhcyB0aW1lZCBv
dXQ/oCBJJ2xsIGRpZyBhIGJpdAogICAgICAgICAgbW9yZS4uLiA8YnI+CiAgICAgICAgICA8YnI+
CiAgICAgICAgICAvSm9uYXMgPGJyPgogICAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgICA8YnI+
CiAgICAgICAgSGkgSm9uYXMsIDxicj4KICAgICAgICA8YnI+CiAgICAgICAgV2hlbiBJIGxvb2sg
YXQgbXkgcGVyc29uYWwgcGF0Y2hlcywgaXQgc2VlbXMgSSd2ZSBhbHJlYWR5IHNlZW4KICAgICAg
ICB0aGF0LiBQbGVhc2UgZmluZCBhdHRhY2hlZCB0aGUgcGF0Y2ggSSBjdXJyZW50bHkgaGF2ZSBp
biBteQogICAgICAgIHNldHVwIG9uIHRoaXMgc3ViamVjdC4gPGJyPgogICAgICAgIDxicj4KICAg
ICAgPC9ibG9ja3F1b3RlPgogICAgICA8YnI+CiAgICAgIFllcywgdGhhdCdzIGV4YWN0bHkgd2hh
dCBJIHdhcyBqdXN0IGluIHRoZSBwcm9jZXNzIG9mCiAgICAgIGltcGxlbWVudGluZy6gIEdsYWQg
eW91IGJlYXQgbWUgdG8gaXQuoCA6KTxicj4KICAgICAgPGJyPgogICAgICBJIHRlc3RlZCB5b3Vy
IHBhdGNoIGFuZCBpdCBzb2x2ZXMgdGhlIHByb2JsZW0uoCBDYW4geW91IHN1Ym1pdCBpdAogICAg
ICB0byB0aGUgbGlzdD+gIElmIG5vdCwgSSB3aWxsLi4uIDopPGJyPgogICAgICA8YnI+CiAgICAg
IEkgdGhpbmsgc2VydmljZV9jcmVhdGVfcmVwbHkoKSBoYXMgdGhlIHNhbWUgaXNzdWUgYnV0IEkg
ZG9uJ3QgaGl0CiAgICAgIGl0IGluIG15IHNldHVwLi48YnI+CiAgICAgIDxicj4KICAgICAgRXN3
YXJhbjqgIHRyeSB0aGUgcGF0Y2ggZnJvbSBDaHJpc3RvcGhlLi4uIEknbSA5OSUgY2VydGFpbiBp
dAogICAgICBzb2x2ZXMgeW91ciBpc3N1ZS48YnI+CiAgICAgIDxicj4KICAgICAgL0pvbmFzPGJy
PgogICAgICA8YnI+CiAgICAgIDxibG9ja3F1b3RlCiAgICAgICAgY2l0ZT0ibWlkOmJhOWM5ZTc4
LWMzZjYtYTc4NC1iYTgzLTQ3MzU3ZDAyOWMxOEBrZXJsaW5rLmZyIgogICAgICAgIHR5cGU9ImNp
dGUiPkNocmlzdG9waGUgPGJyPgogICAgICAgIDxicj4KICAgICAgICA8YnI+CiAgICAgICAgPGJy
PgogICAgICAgIDxicj4KICAgICAgICA8YnI+CiAgICAgICAgPGZpZWxkc2V0IGNsYXNzPSJtaW1l
QXR0YWNobWVudEhlYWRlciI+PC9maWVsZHNldD4KICAgICAgICA8YnI+CiAgICAgICAgPHByZSB3
cmFwPSIiPl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCm9m
b25vIG1haWxpbmcgbGlzdAo8YSBjbGFzcz0ibW96LXR4dC1saW5rLWFiYnJldmlhdGVkIiBocmVm
PSJtYWlsdG86b2Zvbm9Ab2Zvbm8ub3JnIiBtb3otZG8tbm90LXNlbmQ9InRydWUiPm9mb25vQG9m
b25vLm9yZzwvYT4KPGEgY2xhc3M9Im1vei10eHQtbGluay1mcmVldGV4dCIgaHJlZj0iaHR0cHM6
Ly9saXN0cy5vZm9uby5vcmcvbWFpbG1hbi9saXN0aW5mby9vZm9ubyIgbW96LWRvLW5vdC1zZW5k
PSJ0cnVlIj5odHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29mb25vPC9h
Pgo8L3ByZT4KICAgICAgPC9ibG9ja3F1b3RlPgogICAgICA8cD48YnI+CiAgICAgIDwvcD4KICAg
ICAgPGJyPgogICAgICA8ZmllbGRzZXQgY2xhc3M9Im1pbWVBdHRhY2htZW50SGVhZGVyIj48L2Zp
ZWxkc2V0PgogICAgICA8YnI+CiAgICAgIDxwcmUgd3JhcD0iIj5fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpvZm9ubyBtYWlsaW5nIGxpc3QKPGEgY2xhc3M9
Im1vei10eHQtbGluay1hYmJyZXZpYXRlZCIgaHJlZj0ibWFpbHRvOm9mb25vQG9mb25vLm9yZyI+
b2Zvbm9Ab2Zvbm8ub3JnPC9hPgo8YSBjbGFzcz0ibW96LXR4dC1saW5rLWZyZWV0ZXh0IiBocmVm
PSJodHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29mb25vIj5odHRwczov
L2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29mb25vPC9hPgo8L3ByZT4KICAgIDwv
YmxvY2txdW90ZT4KICAgIDxicj4KICA8L2JvZHk+CjwvaHRtbD4K

--===============5451847367986429456==--

