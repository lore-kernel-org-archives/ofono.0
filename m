Content-Type: multipart/mixed; boundary="===============0742232346437037338=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: AW: Ofono 1.21 crashes with Sierra MC7455
Date: Thu, 26 Oct 2017 12:54:08 +0200
Message-ID: <bb1f1944-c187-200b-e545-6fe532f83b6d@southpole.se>
In-Reply-To: <ba9c9e78-c3f6-a784-ba83-47357d029c18@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0742232346437037338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 10/26/2017 12:43 PM, Christophe Ronco wrote:
>
>
>> Seems to be this:
>>
>> i)  When the modem is first powered on, service discovery takes some =

>> time (more than 5 seconds)
>> ii)  The service discovery timeout fires before the QMI request =

>> returns so discover_reply gets called before discover_callback and =

>> things get cleaned up
>> iii)  Then the QMI request returns and discover_callback gets called =

>> even though the request has timed out in ii)
>>
>> ...and this is where things go wrong because the userdata pointer to =

>> discover_callback is probably no longer valid.
>>
>> How do we handle the QMI request returning a _late_ response, i.e. =

>> after it technically has timed out?  I'll dig a bit more...
>>
>> /Jonas
>
> Hi Jonas,
>
> When I look at my personal patches, it seems I've already seen that. =

> Please find attached the patch I currently have in my setup on this =

> subject.
>

Yes, that's exactly what I was just in the process of implementing. Glad =

you beat me to it.  :)

I tested your patch and it solves the problem.  Can you submit it to the =

list?  If not, I will... :)

I think service_create_reply() has the same issue but I don't hit it in =

my setup..

Eswaran:  try the patch from Christophe... I'm 99% certain it solves =

your issue.

/Jonas

> Christophe
>
>
>
>
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono



--===============0742232346437037338==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9d2lu
ZG93cy0xMjUyIgogICAgICBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiPgogIDwvaGVhZD4KICA8
Ym9keSBiZ2NvbG9yPSIjRkZGRkZGIiB0ZXh0PSIjMDAwMDAwIj4KICAgIDxkaXYgY2xhc3M9Im1v
ei1jaXRlLXByZWZpeCI+T24gMTAvMjYvMjAxNyAxMjo0MyBQTSwgQ2hyaXN0b3BoZQogICAgICBS
b25jbyB3cm90ZTo8YnI+CiAgICA8L2Rpdj4KICAgIDxibG9ja3F1b3RlCiAgICAgIGNpdGU9Im1p
ZDpiYTljOWU3OC1jM2Y2LWE3ODQtYmE4My00NzM1N2QwMjljMThAa2VybGluay5mciIKICAgICAg
dHlwZT0iY2l0ZSI+CiAgICAgIDxicj4KICAgICAgPGJyPgogICAgICA8YmxvY2txdW90ZSB0eXBl
PSJjaXRlIj5TZWVtcyB0byBiZSB0aGlzOgogICAgICAgIDxicj4KICAgICAgICA8YnI+CiAgICAg
ICAgaSmgIFdoZW4gdGhlIG1vZGVtIGlzIGZpcnN0IHBvd2VyZWQgb24sIHNlcnZpY2UgZGlzY292
ZXJ5IHRha2VzCiAgICAgICAgc29tZSB0aW1lIChtb3JlIHRoYW4gNSBzZWNvbmRzKQogICAgICAg
IDxicj4KICAgICAgICBpaSmgIFRoZSBzZXJ2aWNlIGRpc2NvdmVyeSB0aW1lb3V0IGZpcmVzIGJl
Zm9yZSB0aGUgUU1JIHJlcXVlc3QKICAgICAgICByZXR1cm5zIHNvIGRpc2NvdmVyX3JlcGx5IGdl
dHMgY2FsbGVkIGJlZm9yZSBkaXNjb3Zlcl9jYWxsYmFjawogICAgICAgIGFuZCB0aGluZ3MgZ2V0
IGNsZWFuZWQgdXAKICAgICAgICA8YnI+CiAgICAgICAgaWlpKaAgVGhlbiB0aGUgUU1JIHJlcXVl
c3QgcmV0dXJucyBhbmQgZGlzY292ZXJfY2FsbGJhY2sgZ2V0cwogICAgICAgIGNhbGxlZCBldmVu
IHRob3VnaCB0aGUgcmVxdWVzdCBoYXMgdGltZWQgb3V0IGluIGlpKQogICAgICAgIDxicj4KICAg
ICAgICA8YnI+CiAgICAgICAgLi4uYW5kIHRoaXMgaXMgd2hlcmUgdGhpbmdzIGdvIHdyb25nIGJl
Y2F1c2UgdGhlIHVzZXJkYXRhCiAgICAgICAgcG9pbnRlciB0byBkaXNjb3Zlcl9jYWxsYmFjayBp
cyBwcm9iYWJseSBubyBsb25nZXIgdmFsaWQuCiAgICAgICAgPGJyPgogICAgICAgIDxicj4KICAg
ICAgICBIb3cgZG8gd2UgaGFuZGxlIHRoZSBRTUkgcmVxdWVzdCByZXR1cm5pbmcgYSBfbGF0ZV8g
cmVzcG9uc2UsCiAgICAgICAgaS5lLiBhZnRlciBpdCB0ZWNobmljYWxseSBoYXMgdGltZWQgb3V0
P6AgSSdsbCBkaWcgYSBiaXQgbW9yZS4uLgogICAgICAgIDxicj4KICAgICAgICA8YnI+CiAgICAg
ICAgL0pvbmFzCiAgICAgICAgPGJyPgogICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgIDxicj4KICAg
ICAgSGkgSm9uYXMsCiAgICAgIDxicj4KICAgICAgPGJyPgogICAgICBXaGVuIEkgbG9vayBhdCBt
eSBwZXJzb25hbCBwYXRjaGVzLCBpdCBzZWVtcyBJJ3ZlIGFscmVhZHkgc2VlbgogICAgICB0aGF0
LiBQbGVhc2UgZmluZCBhdHRhY2hlZCB0aGUgcGF0Y2ggSSBjdXJyZW50bHkgaGF2ZSBpbiBteSBz
ZXR1cAogICAgICBvbiB0aGlzIHN1YmplY3QuCiAgICAgIDxicj4KICAgICAgPGJyPgogICAgPC9i
bG9ja3F1b3RlPgogICAgPGJyPgogICAgWWVzLCB0aGF0J3MgZXhhY3RseSB3aGF0IEkgd2FzIGp1
c3QgaW4gdGhlIHByb2Nlc3Mgb2YgaW1wbGVtZW50aW5nLqAKICAgIEdsYWQgeW91IGJlYXQgbWUg
dG8gaXQuoCA6KTxicj4KICAgIDxicj4KICAgIEkgdGVzdGVkIHlvdXIgcGF0Y2ggYW5kIGl0IHNv
bHZlcyB0aGUgcHJvYmxlbS6gIENhbiB5b3Ugc3VibWl0IGl0IHRvCiAgICB0aGUgbGlzdD+gIElm
IG5vdCwgSSB3aWxsLi4uIDopPGJyPgogICAgPGJyPgogICAgSSB0aGluayBzZXJ2aWNlX2NyZWF0
ZV9yZXBseSgpIGhhcyB0aGUgc2FtZSBpc3N1ZSBidXQgSSBkb24ndCBoaXQgaXQKICAgIGluIG15
IHNldHVwLi48YnI+CiAgICA8YnI+CiAgICBFc3dhcmFuOqAgdHJ5IHRoZSBwYXRjaCBmcm9tIENo
cmlzdG9waGUuLi4gSSdtIDk5JSBjZXJ0YWluIGl0IHNvbHZlcwogICAgeW91ciBpc3N1ZS48YnI+
CiAgICA8YnI+CiAgICAvSm9uYXM8YnI+CiAgICA8YnI+CiAgICA8YmxvY2txdW90ZQogICAgICBj
aXRlPSJtaWQ6YmE5YzllNzgtYzNmNi1hNzg0LWJhODMtNDczNTdkMDI5YzE4QGtlcmxpbmsuZnIi
CiAgICAgIHR5cGU9ImNpdGUiPkNocmlzdG9waGUKICAgICAgPGJyPgogICAgICA8YnI+CiAgICAg
IDxicj4KICAgICAgPGJyPgogICAgICA8YnI+CiAgICAgIDxicj4KICAgICAgPGZpZWxkc2V0IGNs
YXNzPSJtaW1lQXR0YWNobWVudEhlYWRlciI+PC9maWVsZHNldD4KICAgICAgPGJyPgogICAgICA8
cHJlIHdyYXA9IiI+X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18Kb2Zvbm8gbWFpbGluZyBsaXN0CjxhIGNsYXNzPSJtb3otdHh0LWxpbmstYWJicmV2aWF0ZWQi
IGhyZWY9Im1haWx0bzpvZm9ub0BvZm9uby5vcmciPm9mb25vQG9mb25vLm9yZzwvYT4KPGEgY2xh
c3M9Im1vei10eHQtbGluay1mcmVldGV4dCIgaHJlZj0iaHR0cHM6Ly9saXN0cy5vZm9uby5vcmcv
bWFpbG1hbi9saXN0aW5mby9vZm9ubyI+aHR0cHM6Ly9saXN0cy5vZm9uby5vcmcvbWFpbG1hbi9s
aXN0aW5mby9vZm9ubzwvYT4KPC9wcmU+CiAgICA8L2Jsb2NrcXVvdGU+CiAgICA8cD48YnI+CiAg
ICA8L3A+CiAgPC9ib2R5Pgo8L2h0bWw+Cg==

--===============0742232346437037338==--

