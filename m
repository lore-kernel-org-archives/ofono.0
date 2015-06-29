Content-Type: multipart/mixed; boundary="===============1712629775858178095=="
MIME-Version: 1.0
From: Enrico Sau <enrico.sau@gmail.com>
Subject: Re: HE910 + ofono: "Activating context failed with error: Unknown
 error type"
Date: Mon, 29 Jun 2015 14:59:50 +0200
Message-ID: <CAH4ZQwuimaHq1-FXu-NQCj5tGiuwEg1aSXQzPN_Q7bZ6bLRXzQ@mail.gmail.com>
In-Reply-To: <55912900.6090902@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1712629775858178095==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marko,
I had a similar problem with HE910 and I solved with the following code
line immediatly after line 99 in he910.c plugin:

99| g_hash_table_insert(options, "Baud", "115200");
100| *g_hash_table_insert(options, "Local", "on");*

Let me know if it helps.


Enrico


2015-06-29 13:16 GMT+02:00 Marko Sulejic <marko.sulejic@hale.at>:

>
> Am 2015-06-25 um 15:05 schrieb Marko Sulejic:
>
>> Hi again,
>>
>> the problem seems to be in the
>> atmodem/gprs-context.c : gprs_activate_primary
>> function, where
>>
>>     if (g_at_chat_send(gcd->chat, buf, none_prefix,
>>                 at_cgdcont_cb, gc, NULL) > 0)
>>
>> is called after a reconnect, and then it fails.
>>
>>
>> It seems to work if I call
>>
>>     g_at_chat_send(gcd->chat, "AT&C0", none_prefix,
>>                 NULL, NULL, NULL)
>>
>> prior.
>>
>> So this would mean that a disconnect or similar action sets DCD to low,
>> and the chats are closed.
>>
>> Does oFono anywhere in the code sets DCD explicitely to low or is it
>> maybe a bug?
>>
>> My patch would look something like this (if it is an HE910 issue only):
>>
>>     if (gcd->vendor =3D=3D OFONO_VENDOR_TELIT)
>>     {
>>         if(g_at_chat_send(gcd->chat, "AT&C0", none_prefix,
>>                     NULL, NULL, NULL) <=3D 0)
>>             goto error;
>>     }
>>
>>
>> Thanks,
>> Marko
>>
>>
>> Am 2015-06-25 um 11:15 schrieb Marko Sulejic:
>>
>>> Hi,
>>>
>>> I need your help in using a Telit HE910 with ofono (and eventually
>>> connman).
>>> (I am using ofono 1.16 with HE910 firmware version 12.00.006; connman
>>> version is 1.29).
>>>
>>> My problem is the following ...
>>> on startup everything works fine and the ppp0 connection is established,
>>> but problems occur in the following case:
>>>
>>> connmanctl> disconnect cellular_*_context15
>>> Disconnected cellular_*_context15
>>>
>>> connmanctl> connect cellular_*_context15
>>> Error /net/connman/service/cellular_*_context15: Input/output error
>>>
>>>
>>> ofonod[5355]: gprs-context.c(244):at_gprs_activate_primary() cid 1
>>> ofonod[5355]: gprs.c(889):pri_activate_callback() 0x1a18c50
>>> ofonod[5355]: gprs.c(893):pri_activate_callback() Activating context
>>> failed with error: Unknown error type
>>> connmand[3815]: Failed to change property: /he910_0/context15
>>> org.ofono.ConnectionContext.Active: org.ofono.Error.Failed Operation fa=
iled
>>>
>>>
>>> The same error happens if I am manually sending connect/disconnect via
>>> dbus-send.
>>>
>>> Only a hard ofono restart can establish the connection again.
>>> This behavior happens all the time once a ppp0 disconnect happened
>>> (e.g. by removing the SIM; manual disconnect via dbus or connmanctl).
>>>
>>> A subquestion regarding connman:
>>> Can connmand be configured in such a way that on every connection
>>> loss, ofono is triggered to reconnect to the Internet?
>>>
>>> Thank you very muchin advance,
>>> Marko
>>> _______________________________________________
>>> ofono mailing list
>>> ofono(a)ofono.org
>>> https://lists.ofono.org/mailman/listinfo/ofono
>>>
>>
>> _______________________________________________
>> ofono mailing list
>> ofono(a)ofono.org
>> https://lists.ofono.org/mailman/listinfo/ofono
>>
>
>
> Hi,
>
> ok, the above code doesn't seem to solve the problem.
>
> Regards,
>
> Marko
>
>
>
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>

--===============1712629775858178095==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFt
aWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+SGkgTWFya28sPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxf
ZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+SSBoYWQgYSBz
aW1pbGFyIHByb2JsZW0gd2l0aCBIRTkxMCBhbmQgSSBzb2x2ZWQgd2l0aCB0aGUgZm9sbG93aW5n
IGNvZGUgbGluZSBpbW1lZGlhdGx5IGFmdGVywqBsaW5lIDk5IGluIGhlOTEwLmMgcGx1Z2luOjwv
ZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTp2ZXJkYW5h
LHNhbnMtc2VyaWYiPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0i
Zm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj45OXwgZ19oYXNoX3RhYmxlX2luc2VydChv
cHRpb25zLCAmcXVvdDtCYXVkJnF1b3Q7LCAmcXVvdDsxMTUyMDAmcXVvdDspOzwvZGl2PjxkaXYg
Y2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTp2ZXJkYW5hLHNhbnMtc2Vy
aWYiPjEwMHwgPGI+Z19oYXNoX3RhYmxlX2luc2VydChvcHRpb25zLCAmcXVvdDtMb2NhbCZxdW90
OywgJnF1b3Q7b24mcXVvdDspOzwvYj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBz
dHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj48YnI+PC9kaXY+PGRpdiBjbGFz
cz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+
TGV0IG1lIGtub3cgaWYgaXQgaGVscHMuwqA8L2Rpdj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9l
eHRyYSI+PGJyIGNsZWFyPSJhbGwiPjxkaXY+PGRpdiBjbGFzcz0iZ21haWxfc2lnbmF0dXJlIj48
ZGl2Pjxicj48L2Rpdj48ZGl2PkVucmljbzwvZGl2PjxkaXY+PGJyPjwvZGl2PjwvZGl2PjwvZGl2
Pgo8YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjIwMTUtMDYtMjkgMTM6MTYgR01UKzAyOjAw
IE1hcmtvIFN1bGVqaWMgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86bWFya28u
c3VsZWppY0BoYWxlLmF0IiB0YXJnZXQ9Il9ibGFuayI+bWFya28uc3VsZWppY0BoYWxlLmF0PC9h
PiZndDs8L3NwYW4+Ojxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJt
YXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6
MWV4Ij48ZGl2IGNsYXNzPSJIT0VuWmIiPjxkaXYgY2xhc3M9Img1Ij48YnI+CkFtIDIwMTUtMDYt
MjUgdW0gMTU6MDUgc2NocmllYiBNYXJrbyBTdWxlamljOjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9
ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNj
Y2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+CkhpIGFnYWluLDxicj4KPGJyPgp0aGUgcHJvYmxl
bSBzZWVtcyB0byBiZSBpbiB0aGU8YnI+CmF0bW9kZW0vZ3Bycy1jb250ZXh0LmMgOiBncHJzX2Fj
dGl2YXRlX3ByaW1hcnk8YnI+CmZ1bmN0aW9uLCB3aGVyZTxicj4KPGJyPgrCoCDCoCBpZiAoZ19h
dF9jaGF0X3NlbmQoZ2NkLSZndDtjaGF0LCBidWYsIG5vbmVfcHJlZml4LDxicj4KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgYXRfY2dkY29udF9jYiwgZ2MsIE5VTEwpICZndDsgMCk8YnI+Cjxicj4K
aXMgY2FsbGVkIGFmdGVyIGEgcmVjb25uZWN0LCBhbmQgdGhlbiBpdCBmYWlscy48YnI+Cjxicj4K
PGJyPgpJdCBzZWVtcyB0byB3b3JrIGlmIEkgY2FsbDxicj4KPGJyPgrCoCDCoCBnX2F0X2NoYXRf
c2VuZChnY2QtJmd0O2NoYXQsICZxdW90O0FUJmFtcDtDMCZxdW90Oywgbm9uZV9wcmVmaXgsPGJy
PgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOVUxMLCBOVUxMLCBOVUxMKTxicj4KPGJyPgpwcmlv
ci48YnI+Cjxicj4KU28gdGhpcyB3b3VsZCBtZWFuIHRoYXQgYSBkaXNjb25uZWN0IG9yIHNpbWls
YXIgYWN0aW9uIHNldHMgRENEIHRvIGxvdyw8YnI+CmFuZCB0aGUgY2hhdHMgYXJlIGNsb3NlZC48
YnI+Cjxicj4KRG9lcyBvRm9ubyBhbnl3aGVyZSBpbiB0aGUgY29kZSBzZXRzIERDRCBleHBsaWNp
dGVseSB0byBsb3cgb3IgaXMgaXQgbWF5YmUgYSBidWc/PGJyPgo8YnI+Ck15IHBhdGNoIHdvdWxk
IGxvb2sgc29tZXRoaW5nIGxpa2UgdGhpcyAoaWYgaXQgaXMgYW4gSEU5MTAgaXNzdWUgb25seSk6
PGJyPgo8YnI+CsKgIMKgIGlmIChnY2QtJmd0O3ZlbmRvciA9PSBPRk9OT19WRU5ET1JfVEVMSVQp
PGJyPgrCoCDCoCB7PGJyPgrCoCDCoCDCoCDCoCBpZihnX2F0X2NoYXRfc2VuZChnY2QtJmd0O2No
YXQsICZxdW90O0FUJmFtcDtDMCZxdW90Oywgbm9uZV9wcmVmaXgsPGJyPgrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBOVUxMLCBOVUxMLCBOVUxMKSAmbHQ7PSAwKTxicj4KwqAgwqAgwqAg
wqAgwqAgwqAgZ290byBlcnJvcjs8YnI+CsKgIMKgIH08YnI+Cjxicj4KPGJyPgpUaGFua3MsPGJy
PgpNYXJrbzxicj4KPGJyPgo8YnI+CkFtIDIwMTUtMDYtMjUgdW0gMTE6MTUgc2NocmllYiBNYXJr
byBTdWxlamljOjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFy
Z2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFl
eCI+CkhpLDxicj4KPGJyPgpJIG5lZWQgeW91ciBoZWxwIGluIHVzaW5nIGEgVGVsaXQgSEU5MTAg
d2l0aCBvZm9ubyAoYW5kIGV2ZW50dWFsbHkgY29ubm1hbikuPGJyPgooSSBhbSB1c2luZyBvZm9u
byAxLjE2IHdpdGggSEU5MTAgZmlybXdhcmUgdmVyc2lvbiAxMi4wMC4wMDY7IGNvbm5tYW4gdmVy
c2lvbiBpcyAxLjI5KS48YnI+Cjxicj4KTXkgcHJvYmxlbSBpcyB0aGUgZm9sbG93aW5nIC4uLjxi
cj4Kb24gc3RhcnR1cCBldmVyeXRoaW5nIHdvcmtzIGZpbmUgYW5kIHRoZSBwcHAwIGNvbm5lY3Rp
b24gaXMgZXN0YWJsaXNoZWQsPGJyPgpidXQgcHJvYmxlbXMgb2NjdXIgaW4gdGhlIGZvbGxvd2lu
ZyBjYXNlOjxicj4KPGJyPgpjb25ubWFuY3RsJmd0OyBkaXNjb25uZWN0IGNlbGx1bGFyXypfY29u
dGV4dDE1PGJyPgpEaXNjb25uZWN0ZWQgY2VsbHVsYXJfKl9jb250ZXh0MTU8YnI+Cjxicj4KY29u
bm1hbmN0bCZndDsgY29ubmVjdCBjZWxsdWxhcl8qX2NvbnRleHQxNTxicj4KRXJyb3IgL25ldC9j
b25ubWFuL3NlcnZpY2UvY2VsbHVsYXJfKl9jb250ZXh0MTU6IElucHV0L291dHB1dCBlcnJvcjxi
cj4KPGJyPgo8YnI+Cm9mb25vZFs1MzU1XTogZ3Bycy1jb250ZXh0LmMoMjQ0KTphdF9ncHJzX2Fj
dGl2YXRlX3ByaW1hcnkoKSBjaWQgMTxicj4Kb2Zvbm9kWzUzNTVdOiBncHJzLmMoODg5KTpwcmlf
YWN0aXZhdGVfY2FsbGJhY2soKSAweDFhMThjNTA8YnI+Cm9mb25vZFs1MzU1XTogZ3Bycy5jKDg5
Myk6cHJpX2FjdGl2YXRlX2NhbGxiYWNrKCkgQWN0aXZhdGluZyBjb250ZXh0IGZhaWxlZCB3aXRo
IGVycm9yOiBVbmtub3duIGVycm9yIHR5cGU8YnI+CmNvbm5tYW5kWzM4MTVdOiBGYWlsZWQgdG8g
Y2hhbmdlIHByb3BlcnR5OiAvaGU5MTBfMC9jb250ZXh0MTUgb3JnLm9mb25vLkNvbm5lY3Rpb25D
b250ZXh0LkFjdGl2ZTogb3JnLm9mb25vLkVycm9yLkZhaWxlZCBPcGVyYXRpb24gZmFpbGVkPGJy
Pgo8YnI+Cjxicj4KVGhlIHNhbWUgZXJyb3IgaGFwcGVucyBpZiBJIGFtIG1hbnVhbGx5IHNlbmRp
bmcgY29ubmVjdC9kaXNjb25uZWN0IHZpYSBkYnVzLXNlbmQuPGJyPgo8YnI+Ck9ubHkgYSBoYXJk
IG9mb25vIHJlc3RhcnQgY2FuIGVzdGFibGlzaCB0aGUgY29ubmVjdGlvbiBhZ2Fpbi48YnI+ClRo
aXMgYmVoYXZpb3IgaGFwcGVucyBhbGwgdGhlIHRpbWUgb25jZSBhIHBwcDAgZGlzY29ubmVjdCBo
YXBwZW5lZDxicj4KKGUuZy4gYnkgcmVtb3ZpbmcgdGhlIFNJTTsgbWFudWFsIGRpc2Nvbm5lY3Qg
dmlhIGRidXMgb3IgY29ubm1hbmN0bCkuPGJyPgo8YnI+CkEgc3VicXVlc3Rpb24gcmVnYXJkaW5n
IGNvbm5tYW46PGJyPgpDYW4gY29ubm1hbmQgYmUgY29uZmlndXJlZCBpbiBzdWNoIGEgd2F5IHRo
YXQgb24gZXZlcnkgY29ubmVjdGlvbjxicj4KbG9zcywgb2Zvbm8gaXMgdHJpZ2dlcmVkIHRvIHJl
Y29ubmVjdCB0byB0aGUgSW50ZXJuZXQ/PGJyPgo8YnI+ClRoYW5rIHlvdSB2ZXJ5IG11Y2hpbiBh
ZHZhbmNlLDxicj4KTWFya288YnI+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fPGJyPgpvZm9ubyBtYWlsaW5nIGxpc3Q8YnI+CjxhIGhyZWY9Im1haWx0bzpv
Zm9ub0BvZm9uby5vcmciIHRhcmdldD0iX2JsYW5rIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8
YSBocmVmPSJodHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29mb25vIiBy
ZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2xpc3RzLm9mb25vLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL29mb25vPC9hPjxicj4KPC9ibG9ja3F1b3RlPgo8YnI+Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fPGJyPgpvZm9ubyBtYWlsaW5n
IGxpc3Q8YnI+CjxhIGhyZWY9Im1haWx0bzpvZm9ub0BvZm9uby5vcmciIHRhcmdldD0iX2JsYW5r
Ij5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8YSBocmVmPSJodHRwczovL2xpc3RzLm9mb25vLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL29mb25vIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5r
Ij5odHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29mb25vPC9hPjxicj4K
PC9ibG9ja3F1b3RlPgo8YnI+Cjxicj48L2Rpdj48L2Rpdj4KSGksPGJyPgo8YnI+Cm9rLCB0aGUg
YWJvdmUgY29kZSBkb2VzbiYjMzk7dCBzZWVtIHRvIHNvbHZlIHRoZSBwcm9ibGVtLjxicj4KPGJy
PgpSZWdhcmRzLDxkaXYgY2xhc3M9IkhPRW5aYiI+PGRpdiBjbGFzcz0iaDUiPjxicj4KTWFya288
YnI+Cjxicj4KPGJyPgo8YnI+Cjxicj4KPGJyPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXzxicj4Kb2Zvbm8gbWFpbGluZyBsaXN0PGJyPgo8YSBocmVmPSJt
YWlsdG86b2Zvbm9Ab2Zvbm8ub3JnIiB0YXJnZXQ9Il9ibGFuayI+b2Zvbm9Ab2Zvbm8ub3JnPC9h
Pjxicj4KPGEgaHJlZj0iaHR0cHM6Ly9saXN0cy5vZm9uby5vcmcvbWFpbG1hbi9saXN0aW5mby9v
Zm9ubyIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9saXN0cy5vZm9u
by5vcmcvbWFpbG1hbi9saXN0aW5mby9vZm9ubzwvYT48YnI+CjwvZGl2PjwvZGl2PjwvYmxvY2tx
dW90ZT48L2Rpdj48YnI+PC9kaXY+Cg==

--===============1712629775858178095==--

