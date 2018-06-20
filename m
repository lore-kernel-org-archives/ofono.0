Content-Type: multipart/mixed; boundary="===============1729775587319125053=="
MIME-Version: 1.0
From: Mattias =?unknown-8bit?q?M=C3=A5nsson?= <mattias.mansson@verisure.com>
Subject: SV: Handling empty row from AT command
Date: Wed, 20 Jun 2018 13:24:18 +0000
Message-ID: <AM5PR1001MB1171B048483CE3C97BE6584896770@AM5PR1001MB1171.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <d72eb358-78a5-ef3d-c1fe-8ec83fcba27c@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1729775587319125053==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It seems we already use that parser though:

syntax =3D g_at_syntax_new_gsm_permissive();
chat =3D g_at_chat_new(channel, syntax);

________________________________
Fr=C3=A5n: Denis Kenzior <denkenz@gmail.com>
Skickat: den 20 juni 2018 15:20:13
Till: Mattias M=C3=A5nsson; ofono(a)ofono.org
=C3=84mne: Re: Handling empty row from AT command

Hi Mattias,

On 06/20/2018 02:34 AM, Mattias M=C3=A5nsson wrote:
> I'm integrating a new Cinterion module and have a small issue I haven't
> been able to solve nicely in Ofono. One of their commands responds with
> a list of stuff, followed by an OK but also after the OK there is an
> empty line. Which is of course wrong, but it might not be solved for a
> while. Using the g_at_chat_send function with a callback doesn't seem to
> work then, the callback will not be called it seems and I get stuck in
> the sequence. Can I without modifying the AT parser handle this somehow?
>

Nope, the parser is what actually drives command recognition.  So
sending empty commands, etc won't work.

If you're using the gsmv1 parser, then try switching to permissive.
Permissive is generally able to deal with such situations.

Regards,
-Denis

--===============1729775587319125053==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CjxoZWFkPgo8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRlbnQ9InRl
eHQvaHRtbDsgY2hhcnNldD1pc28tODg1OS0xIj4KPHN0eWxlIHR5cGU9InRleHQvY3NzIiBzdHls
ZT0iZGlzcGxheTpub25lOyI+PCEtLSBQIHttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO30g
LS0+PC9zdHlsZT4KPC9oZWFkPgo8Ym9keSBkaXI9Imx0ciI+CjxkaXYgaWQ9ImRpdnRhZ2RlZmF1
bHR3cmFwcGVyIiBzdHlsZT0iZm9udC1zaXplOjEycHQ7Y29sb3I6IzAwMDAwMDtmb250LWZhbWls
eTpDYWxpYnJpLEhlbHZldGljYSxzYW5zLXNlcmlmOyIgZGlyPSJsdHIiPgpJdCBzZWVtcyB3ZSBh
bHJlYWR5IHVzZSB0aGF0IHBhcnNlciB0aG91Z2g6CjxkaXY+PGJyPgo8L2Rpdj4KPGRpdj4KPGRp
dj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj48L3NwYW4+c3ludGF4ID0gZ19hdF9zeW50
YXhfbmV3X2dzbV9wZXJtaXNzaXZlKCk7PC9kaXY+CjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+PC9zcGFuPmNoYXQgPSBnX2F0X2NoYXRfbmV3KGNoYW5uZWwsIHN5bnRheCk7PC9k
aXY+Cjxicj4KPC9kaXY+CjwvZGl2Pgo8aHIgc3R5bGU9ImRpc3BsYXk6aW5saW5lLWJsb2NrO3dp
ZHRoOjk4JSIgdGFiaW5kZXg9Ii0xIj4KPGRpdiBpZD0iZGl2UnBseUZ3ZE1zZyIgZGlyPSJsdHIi
Pjxmb250IGZhY2U9IkNhbGlicmksIHNhbnMtc2VyaWYiIHN0eWxlPSJmb250LXNpemU6MTFwdCIg
Y29sb3I9IiMwMDAwMDAiPjxiPkZy5W46PC9iPiBEZW5pcyBLZW56aW9yICZsdDtkZW5rZW56QGdt
YWlsLmNvbSZndDs8YnI+CjxiPlNraWNrYXQ6PC9iPiBkZW4gMjAganVuaSAyMDE4IDE1OjIwOjEz
PGJyPgo8Yj5UaWxsOjwvYj4gTWF0dGlhcyBN5W5zc29uOyBvZm9ub0BvZm9uby5vcmc8YnI+Cjxi
PsRtbmU6PC9iPiBSZTogSGFuZGxpbmcgZW1wdHkgcm93IGZyb20gQVQgY29tbWFuZDwvZm9udD4K
PGRpdj4mbmJzcDs8L2Rpdj4KPC9kaXY+CjxkaXYgY2xhc3M9IkJvZHlGcmFnbWVudCI+PGZvbnQg
c2l6ZT0iMiI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMXB0OyI+CjxkaXYgY2xhc3M9IlBsYWlu
VGV4dCI+SGkgTWF0dGlhcyw8YnI+Cjxicj4KT24gMDYvMjAvMjAxOCAwMjozNCBBTSwgTWF0dGlh
cyBN5W5zc29uIHdyb3RlOjxicj4KJmd0OyBJJ20gaW50ZWdyYXRpbmcgYSBuZXcgQ2ludGVyaW9u
IG1vZHVsZSBhbmQgaGF2ZSBhIHNtYWxsIGlzc3VlIEkgaGF2ZW4ndCA8YnI+CiZndDsgYmVlbiBh
YmxlIHRvIHNvbHZlIG5pY2VseSBpbiBPZm9uby4gT25lIG9mIHRoZWlyIGNvbW1hbmRzIHJlc3Bv
bmRzIHdpdGggPGJyPgomZ3Q7IGEgbGlzdCBvZiBzdHVmZiwgZm9sbG93ZWQgYnkgYW4gT0sgYnV0
IGFsc28gYWZ0ZXIgdGhlIE9LIHRoZXJlIGlzIGFuIDxicj4KJmd0OyBlbXB0eSBsaW5lLiBXaGlj
aCBpcyBvZiBjb3Vyc2Ugd3JvbmcsIGJ1dCBpdCBtaWdodCBub3QgYmUgc29sdmVkIGZvciBhIDxi
cj4KJmd0OyB3aGlsZS4mbmJzcDtVc2luZyB0aGUgZ19hdF9jaGF0X3NlbmQgZnVuY3Rpb24gd2l0
aCBhIGNhbGxiYWNrIGRvZXNuJ3Qgc2VlbSB0byA8YnI+CiZndDsgd29yayB0aGVuLCB0aGUgY2Fs
bGJhY2sgd2lsbCBub3QgYmUgY2FsbGVkIGl0IHNlZW1zJm5ic3A7YW5kIEkgZ2V0IHN0dWNrIGlu
IDxicj4KJmd0OyB0aGUgc2VxdWVuY2UuIENhbiBJIHdpdGhvdXQgbW9kaWZ5aW5nIHRoZSBBVCBw
YXJzZXIgaGFuZGxlIHRoaXMgc29tZWhvdz88YnI+CiZndDsgPGJyPgo8YnI+Ck5vcGUsIHRoZSBw
YXJzZXIgaXMgd2hhdCBhY3R1YWxseSBkcml2ZXMgY29tbWFuZCByZWNvZ25pdGlvbi4mbmJzcDsg
U28gPGJyPgpzZW5kaW5nIGVtcHR5IGNvbW1hbmRzLCBldGMgd29uJ3Qgd29yay48YnI+Cjxicj4K
SWYgeW91J3JlIHVzaW5nIHRoZSBnc212MSBwYXJzZXIsIHRoZW4gdHJ5IHN3aXRjaGluZyB0byBw
ZXJtaXNzaXZlLiA8YnI+ClBlcm1pc3NpdmUgaXMgZ2VuZXJhbGx5IGFibGUgdG8gZGVhbCB3aXRo
IHN1Y2ggc2l0dWF0aW9ucy48YnI+Cjxicj4KUmVnYXJkcyw8YnI+Ci1EZW5pczxicj4KPC9kaXY+
Cjwvc3Bhbj48L2ZvbnQ+PC9kaXY+CjwvYm9keT4KPC9odG1sPgo=

--===============1729775587319125053==--

