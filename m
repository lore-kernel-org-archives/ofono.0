Content-Type: multipart/mixed; boundary="===============5510284674935111804=="
MIME-Version: 1.0
From: Sankar <gsankar.gs@gmail.com>
Subject: Re: [RFC PATCH 2/3] ssn: add code and call id to notifications
Date: Tue, 22 Feb 2011 17:37:12 +0530
Message-ID: <AANLkTi=XHVW0VteBvk2tkhbdwRdcDdMZmYAesMWSm9VR@mail.gmail.com>
In-Reply-To: <4D53ABE6.7000709@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5510284674935111804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis/Andras,

Is this patch applied and available in the GIT?

Regards,
Sankar.

On Thu, Feb 10, 2011 at 2:42 PM, Andras Domokos <andras.domokos@nokia.com=
>wrote:

> Hi Denis,
>
>
> On 02/10/2011 05:08 AM, ext Denis Kenzior wrote:
>
>> Hi Andras,
>>
>>  diff --git a/include/ssn.h b/include/ssn.h
>>> index d640cad..ba3701b 100644
>>> --- a/include/ssn.h
>>> +++ b/include/ssn.h
>>> @@ -37,9 +37,10 @@ struct ofono_ssn_driver {
>>>  };
>>>
>>>  /* SSN notifications (CSSI and CSSU).  */
>>> -void ofono_ssn_cssi_notify(struct ofono_ssn *ssn, int code, int index);
>>> -void ofono_ssn_cssu_notify(struct ofono_ssn *ssn, int code, int index,
>>> -                               const struct ofono_phone_number *number=
);
>>> +void ofono_ssn_cssi_notify(struct ofono_ssn *ssn, unsigned int id,
>>> +                               int code1, int index);
>>> +void ofono_ssn_cssu_notify(struct ofono_ssn *ssn, unsigned int id, int
>>> code2,
>>> +                       int index, const struct ofono_phone_number
>>> *number);
>>>
>>>  int ofono_ssn_driver_register(const struct ofono_ssn_driver *d);
>>>  void ofono_ssn_driver_unregister(const struct ofono_ssn_driver *d);
>>>
>> Right now I'm not seeing any users (or even potential ones) of the SSN
>> atom besides voicecall.  What do you think of removing the SSN atom and
>> moving these to the voicecall atom?
>>
> Yes, we talked about removing the SSN atom, but I thought I would
> keep it for now, it can be removed any time later, anyways, doesn't
> save much removing it.
>
>
>  The only one I'm not sure about is<code2>  from 27.007:
>> 6       forward check SS message received (can be received whenever)
>>
>> Any idea what this one is about?
>>
>>  Never encountered this message, and I am not sure what is it for.
> A patch for handling this message can be submitted later, if a real
> life case is found for it.
>
>  Regards,
>> -Denis
>>
> Regards,
> Andras
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============5510284674935111804==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgRGVuaXMvQW5kcmFzLDxicj48YnI+SXMgdGhpcyBwYXRjaCBhcHBsaWVkIGFuZCBhdmFpbGFi
bGUgaW4gdGhlIEdJVD88YnI+PGJyPlJlZ2FyZHMsPGJyPlNhbmthci48YnI+PGJyPjxkaXYgY2xh
c3M9ImdtYWlsX3F1b3RlIj5PbiBUaHUsIEZlYiAxMCwgMjAxMSBhdCAyOjQyIFBNLCBBbmRyYXMg
RG9tb2tvcyA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzphbmRyYXMuZG9tb2tv
c0Bub2tpYS5jb20iPmFuZHJhcy5kb21va29zQG5va2lhLmNvbTwvYT4mZ3Q7PC9zcGFuPiB3cm90
ZTo8YnI+CjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9ImJvcmRlci1sZWZ0
OiAxcHggc29saWQgcmdiKDIwNCwgMjA0LCAyMDQpOyBtYXJnaW46IDBwdCAwcHQgMHB0IDAuOGV4
OyBwYWRkaW5nLWxlZnQ6IDFleDsiPkhpIERlbmlzLDxkaXYgY2xhc3M9ImltIj48YnI+Cjxicj4K
T24gMDIvMTAvMjAxMSAwNTowOCBBTSwgZXh0IERlbmlzIEtlbnppb3Igd3JvdGU6PGJyPgo8Ymxv
Y2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJib3JkZXItbGVmdDogMXB4IHNvbGlk
IHJnYigyMDQsIDIwNCwgMjA0KTsgbWFyZ2luOiAwcHQgMHB0IDBwdCAwLjhleDsgcGFkZGluZy1s
ZWZ0OiAxZXg7Ij4KSGkgQW5kcmFzLDxicj4KPGJyPgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxf
cXVvdGUiIHN0eWxlPSJib3JkZXItbGVmdDogMXB4IHNvbGlkIHJnYigyMDQsIDIwNCwgMjA0KTsg
bWFyZ2luOiAwcHQgMHB0IDBwdCAwLjhleDsgcGFkZGluZy1sZWZ0OiAxZXg7Ij4KZGlmZiAtLWdp
dCBhL2luY2x1ZGUvc3NuLmggYi9pbmNsdWRlL3Nzbi5oPGJyPgppbmRleCBkNjQwY2FkLi5iYTM3
MDFiIDEwMDY0NDxicj4KLS0tIGEvaW5jbHVkZS9zc24uaDxicj4KKysrIGIvaW5jbHVkZS9zc24u
aDxicj4KQEAgLTM3LDkgKzM3LDEwIEBAIHN0cnVjdCBvZm9ub19zc25fZHJpdmVyIHs8YnI+CiCg
fTs8YnI+Cjxicj4KIKAvKiBTU04gbm90aWZpY2F0aW9ucyAoQ1NTSSBhbmQgQ1NTVSkuIKAqLzxi
cj4KLXZvaWQgb2Zvbm9fc3NuX2Nzc2lfbm90aWZ5KHN0cnVjdCBvZm9ub19zc24gKnNzbiwgaW50
IGNvZGUsIGludCBpbmRleCk7PGJyPgotdm9pZCBvZm9ub19zc25fY3NzdV9ub3RpZnkoc3RydWN0
IG9mb25vX3NzbiAqc3NuLCBpbnQgY29kZSwgaW50IGluZGV4LDxicj4KLSCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCBjb25zdCBzdHJ1Y3Qgb2Zvbm9fcGhvbmVfbnVtYmVyICpudW1iZXIp
Ozxicj4KK3ZvaWQgb2Zvbm9fc3NuX2Nzc2lfbm90aWZ5KHN0cnVjdCBvZm9ub19zc24gKnNzbiwg
dW5zaWduZWQgaW50IGlkLDxicj4KKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBpbnQg
Y29kZTEsIGludCBpbmRleCk7PGJyPgordm9pZCBvZm9ub19zc25fY3NzdV9ub3RpZnkoc3RydWN0
IG9mb25vX3NzbiAqc3NuLCB1bnNpZ25lZCBpbnQgaWQsIGludCBjb2RlMiw8YnI+CisgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIGludCBpbmRleCwgY29uc3Qgc3RydWN0IG9mb25vX3Bob25lX251bWJl
ciAqbnVtYmVyKTs8YnI+Cjxicj4KIKBpbnQgb2Zvbm9fc3NuX2RyaXZlcl9yZWdpc3Rlcihjb25z
dCBzdHJ1Y3Qgb2Zvbm9fc3NuX2RyaXZlciAqZCk7PGJyPgogoHZvaWQgb2Zvbm9fc3NuX2RyaXZl
cl91bnJlZ2lzdGVyKGNvbnN0IHN0cnVjdCBvZm9ub19zc25fZHJpdmVyICpkKTs8YnI+CjwvYmxv
Y2txdW90ZT4KUmlnaHQgbm93IEkmIzM5O20gbm90IHNlZWluZyBhbnkgdXNlcnMgKG9yIGV2ZW4g
cG90ZW50aWFsIG9uZXMpIG9mIHRoZSBTU048YnI+CmF0b20gYmVzaWRlcyB2b2ljZWNhbGwuIKBX
aGF0IGRvIHlvdSB0aGluayBvZiByZW1vdmluZyB0aGUgU1NOIGF0b20gYW5kPGJyPgptb3Zpbmcg
dGhlc2UgdG8gdGhlIHZvaWNlY2FsbCBhdG9tPzxicj4KPC9ibG9ja3F1b3RlPjwvZGl2PgpZZXMs
IHdlIHRhbGtlZCBhYm91dCByZW1vdmluZyB0aGUgU1NOIGF0b20sIGJ1dCBJIHRob3VnaHQgSSB3
b3VsZDxicj4Ka2VlcCBpdCBmb3Igbm93LCBpdCBjYW4gYmUgcmVtb3ZlZCBhbnkgdGltZSBsYXRl
ciwgYW55d2F5cywgZG9lc24mIzM5O3Q8YnI+CnNhdmUgbXVjaCByZW1vdmluZyBpdC48ZGl2IGNs
YXNzPSJpbSI+PGJyPgo8YnI+CjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9
ImJvcmRlci1sZWZ0OiAxcHggc29saWQgcmdiKDIwNCwgMjA0LCAyMDQpOyBtYXJnaW46IDBwdCAw
cHQgMHB0IDAuOGV4OyBwYWRkaW5nLWxlZnQ6IDFleDsiPgpUaGUgb25seSBvbmUgSSYjMzk7bSBu
b3Qgc3VyZSBhYm91dCBpcyZsdDtjb2RlMiZndDsgoGZyb20gMjcuMDA3Ojxicj4KNiCgIKAgoCBm
b3J3YXJkIGNoZWNrIFNTIG1lc3NhZ2UgcmVjZWl2ZWQgKGNhbiBiZSByZWNlaXZlZCB3aGVuZXZl
cik8YnI+Cjxicj4KQW55IGlkZWEgd2hhdCB0aGlzIG9uZSBpcyBhYm91dD88YnI+Cjxicj4KPC9i
bG9ja3F1b3RlPjwvZGl2PgpOZXZlciBlbmNvdW50ZXJlZCB0aGlzIG1lc3NhZ2UsIGFuZCBJIGFt
IG5vdCBzdXJlIHdoYXQgaXMgaXQgZm9yLjxicj4KQSBwYXRjaCBmb3IgaGFuZGxpbmcgdGhpcyBt
ZXNzYWdlIGNhbiBiZSBzdWJtaXR0ZWQgbGF0ZXIsIGlmIGEgcmVhbDxicj4KbGlmZSBjYXNlIGlz
IGZvdW5kIGZvciBpdC48YnI+Cjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0iYm9yZGVyLWxlZnQ6IDFweCBzb2xpZCByZ2IoMjA0LCAyMDQsIDIwNCk7IG1hcmdpbjog
MHB0IDBwdCAwcHQgMC44ZXg7IHBhZGRpbmctbGVmdDogMWV4OyI+ClJlZ2FyZHMsPGJyPgotRGVu
aXM8YnI+CjwvYmxvY2txdW90ZT4KUmVnYXJkcyw8YnI+PGZvbnQgY29sb3I9IiM4ODg4ODgiPgpB
bmRyYXM8L2ZvbnQ+PGRpdj48ZGl2PjwvZGl2PjxkaXYgY2xhc3M9Img1Ij48YnI+Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fPGJyPgpvZm9ubyBtYWlsaW5n
IGxpc3Q8YnI+CjxhIGhyZWY9Im1haWx0bzpvZm9ub0BvZm9uby5vcmciIHRhcmdldD0iX2JsYW5r
Ij5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8YSBocmVmPSJodHRwOi8vbGlzdHMub2Zvbm8ub3Jn
L2xpc3RpbmZvL29mb25vIiB0YXJnZXQ9Il9ibGFuayI+aHR0cDovL2xpc3RzLm9mb25vLm9yZy9s
aXN0aW5mby9vZm9ubzwvYT48YnI+CjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48L2Rpdj48YnI+
Cg==

--===============5510284674935111804==--

