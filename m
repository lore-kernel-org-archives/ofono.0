Content-Type: multipart/mixed; boundary="===============8282979430538314087=="
MIME-Version: 1.0
From: Mattias =?unknown-8bit?q?M=C3=A5nsson?= <mattias.mansson@verisure.com>
Subject: SV: SV: Handling empty row from AT command
Date: Wed, 20 Jun 2018 13:33:05 +0000
Message-ID: <AM5PR1001MB1171EF34A2E8FDF1FB8140AA96770@AM5PR1001MB1171.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <3f286d85-c72a-e4e2-c203-3524744595f5@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8282979430538314087==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I will do some experiments and come back to you with logs...

________________________________
Fr=C3=A5n: Denis Kenzior <denkenz@gmail.com>
Skickat: den 20 juni 2018 15:30:00
Till: Mattias M=C3=A5nsson; ofono(a)ofono.org
=C3=84mne: Re: SV: Handling empty row from AT command

Hi Mattias,

On 06/20/2018 08:24 AM, Mattias M=C3=A5nsson wrote:
> It seems we already use that parser though:
>
> syntax =3D g_at_syntax_new_gsm_permissive();
> chat =3D g_at_chat_new(channel, syntax);
>

Not sure then.  Permissive should be taking care of the issue you
describe, e.g it skips any empty lines:

                 case GSM_PERMISSIVE_STATE_IDLE:
                         if (byte =3D=3D '\r' || byte =3D=3D '\n')
                                 /* ignore */;

Maybe there's something more subtle going on?  Are there stray
whitespace characters or something else in the spurious response?  You
would have to trace why the permissive syntax fails and either fix it or
design your own.

Regards,
-Denis

--===============8282979430538314087==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CjxoZWFkPgo8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRlbnQ9InRl
eHQvaHRtbDsgY2hhcnNldD1pc28tODg1OS0xIj4KPHN0eWxlIHR5cGU9InRleHQvY3NzIiBzdHls
ZT0iZGlzcGxheTpub25lOyI+PCEtLSBQIHttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO30g
LS0+PC9zdHlsZT4KPC9oZWFkPgo8Ym9keSBkaXI9Imx0ciI+CjxkaXYgaWQ9ImRpdnRhZ2RlZmF1
bHR3cmFwcGVyIiBzdHlsZT0iZm9udC1zaXplOjEycHQ7Y29sb3I6IzAwMDAwMDtmb250LWZhbWls
eTpDYWxpYnJpLEhlbHZldGljYSxzYW5zLXNlcmlmOyIgZGlyPSJsdHIiPgo8cCBzdHlsZT0ibWFy
Z2luLXRvcDowO21hcmdpbi1ib3R0b206MCI+SSB3aWxsIGRvIHNvbWUgZXhwZXJpbWVudHMgYW5k
IGNvbWUgYmFjayB0byB5b3Ugd2l0aCBsb2dzLi4uPC9wPgo8L2Rpdj4KPGhyIHN0eWxlPSJkaXNw
bGF5OmlubGluZS1ibG9jazt3aWR0aDo5OCUiIHRhYmluZGV4PSItMSI+CjxkaXYgaWQ9ImRpdlJw
bHlGd2RNc2ciIGRpcj0ibHRyIj48Zm9udCBmYWNlPSJDYWxpYnJpLCBzYW5zLXNlcmlmIiBzdHls
ZT0iZm9udC1zaXplOjExcHQiIGNvbG9yPSIjMDAwMDAwIj48Yj5GcuVuOjwvYj4gRGVuaXMgS2Vu
emlvciAmbHQ7ZGVua2VuekBnbWFpbC5jb20mZ3Q7PGJyPgo8Yj5Ta2lja2F0OjwvYj4gZGVuIDIw
IGp1bmkgMjAxOCAxNTozMDowMDxicj4KPGI+VGlsbDo8L2I+IE1hdHRpYXMgTeVuc3Nvbjsgb2Zv
bm9Ab2Zvbm8ub3JnPGJyPgo8Yj7EbW5lOjwvYj4gUmU6IFNWOiBIYW5kbGluZyBlbXB0eSByb3cg
ZnJvbSBBVCBjb21tYW5kPC9mb250Pgo8ZGl2PiZuYnNwOzwvZGl2Pgo8L2Rpdj4KPGRpdiBjbGFz
cz0iQm9keUZyYWdtZW50Ij48Zm9udCBzaXplPSIyIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEx
cHQ7Ij4KPGRpdiBjbGFzcz0iUGxhaW5UZXh0Ij5IaSBNYXR0aWFzLDxicj4KPGJyPgpPbiAwNi8y
MC8yMDE4IDA4OjI0IEFNLCBNYXR0aWFzIE3lbnNzb24gd3JvdGU6PGJyPgomZ3Q7IEl0IHNlZW1z
IHdlIGFscmVhZHkgdXNlIHRoYXQgcGFyc2VyIHRob3VnaDo8YnI+CiZndDsgPGJyPgomZ3Q7IHN5
bnRheCA9IGdfYXRfc3ludGF4X25ld19nc21fcGVybWlzc2l2ZSgpOzxicj4KJmd0OyBjaGF0ID0g
Z19hdF9jaGF0X25ldyhjaGFubmVsLCBzeW50YXgpOzxicj4KJmd0OyA8YnI+Cjxicj4KTm90IHN1
cmUgdGhlbi4mbmJzcDsgUGVybWlzc2l2ZSBzaG91bGQgYmUgdGFraW5nIGNhcmUgb2YgdGhlIGlz
c3VlIHlvdSA8YnI+CmRlc2NyaWJlLCBlLmcgaXQgc2tpcHMgYW55IGVtcHR5IGxpbmVzOjxicj4K
PGJyPgombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgY2FzZSBHU01fUEVS
TUlTU0lWRV9TVEFURV9JRExFOjxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGlm
IChieXRlID09ICdccicgfHwgYnl0ZSA9PSAnXG4nKTxicj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IC8qIGlnbm9yZSAqLzs8YnI+Cjxicj4KTWF5YmUgdGhlcmUncyBzb21ldGhpbmcgbW9yZSBzdWJ0
bGUgZ29pbmcgb24/Jm5ic3A7IEFyZSB0aGVyZSBzdHJheSA8YnI+CndoaXRlc3BhY2UgY2hhcmFj
dGVycyBvciBzb21ldGhpbmcgZWxzZSBpbiB0aGUgc3B1cmlvdXMgcmVzcG9uc2U/Jm5ic3A7IFlv
dSA8YnI+CndvdWxkIGhhdmUgdG8gdHJhY2Ugd2h5IHRoZSBwZXJtaXNzaXZlIHN5bnRheCBmYWls
cyBhbmQgZWl0aGVyIGZpeCBpdCBvciA8YnI+CmRlc2lnbiB5b3VyIG93bi48YnI+Cjxicj4KUmVn
YXJkcyw8YnI+Ci1EZW5pczxicj4KPC9kaXY+Cjwvc3Bhbj48L2ZvbnQ+PC9kaXY+CjwvYm9keT4K
PC9odG1sPgo=

--===============8282979430538314087==--

