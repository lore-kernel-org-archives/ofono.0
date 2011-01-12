Content-Type: multipart/mixed; boundary="===============7480162550886063741=="
MIME-Version: 1.0
From: Tomasz Gregorek <tomasz.gregorek@gmail.com>
Subject: Re: [PATCH] plugins-mbm: Combining mbm_disable and reopen_callback
Date: Wed, 12 Jan 2011 18:26:27 +0100
Message-ID: <AANLkTim3ZMKZWDhLk5iWdObiQTBgJZXbTUKos=ZXB+Ym@mail.gmail.com>
In-Reply-To: <1294848806.3873.81.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7480162550886063741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel
I already had my solution in head and misunderstood you. I will correct and
retest it.
Br
Tomasz

2011/1/12 Marcel Holtmann <marcel@holtmann.org>

> Hi Tomasz,
>
> > Combining mbm_disable and reopen_callback into one and removing 1 second
> > delay between them to avoid call to reopen_callback after modem being
> > disconnected.
>
> have you actually tested this? This will not work since you can not
> reopen the TTY right away. You need that delay in between.
>
> From my previous email, I remember saying that the right fix would be to
> disarm the timer within disable. Why are we not doing that?
>
> Regards
>
> Marcel
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============7480162550886063741==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgTWFyY2VsPGJyPkkgYWxyZWFkeSBoYWQgbXkgc29sdXRpb24gaW4gaGVhZCBhbmQgbWlzdW5k
ZXJzdG9vZCB5b3UuIEkgd2lsbCBjb3JyZWN0IGFuZCByZXRlc3QgaXQuPGJyPkJyPGJyPlRvbWFz
ejxicj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjIwMTEvMS8xMiBNYXJjZWwgSG9sdG1h
bm4gPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86bWFyY2VsQGhvbHRtYW5uLm9y
ZyI+bWFyY2VsQGhvbHRtYW5uLm9yZzwvYT4mZ3Q7PC9zcGFuPjxicj4KPGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4
ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleDsiPkhpIFRvbWFzeiw8YnI+CjxkaXYgY2xhc3M9
ImltIj48YnI+CiZndDsgQ29tYmluaW5nIG1ibV9kaXNhYmxlIGFuZCByZW9wZW5fY2FsbGJhY2sg
aW50byBvbmUgYW5kIHJlbW92aW5nIDEgc2Vjb25kPGJyPgomZ3Q7IGRlbGF5IGJldHdlZW4gdGhl
bSB0byBhdm9pZCBjYWxsIHRvIHJlb3Blbl9jYWxsYmFjayBhZnRlciBtb2RlbSBiZWluZzxicj4K
Jmd0OyBkaXNjb25uZWN0ZWQuPGJyPgo8YnI+CjwvZGl2PmhhdmUgeW91IGFjdHVhbGx5IHRlc3Rl
ZCB0aGlzPyBUaGlzIHdpbGwgbm90IHdvcmsgc2luY2UgeW91IGNhbiBub3Q8YnI+CnJlb3BlbiB0
aGUgVFRZIHJpZ2h0IGF3YXkuIFlvdSBuZWVkIHRoYXQgZGVsYXkgaW4gYmV0d2Vlbi48YnI+Cjxi
cj4KPkZyb20gbXkgcHJldmlvdXMgZW1haWwsIEkgcmVtZW1iZXIgc2F5aW5nIHRoYXQgdGhlIHJp
Z2h0IGZpeCB3b3VsZCBiZSB0bzxicj4KZGlzYXJtIHRoZSB0aW1lciB3aXRoaW4gZGlzYWJsZS4g
V2h5IGFyZSB3ZSBub3QgZG9pbmcgdGhhdD88YnI+Cjxicj4KUmVnYXJkczxicj4KPGJyPgpNYXJj
ZWw8YnI+Cjxicj4KPGJyPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXzxicj4Kb2Zvbm8gbWFpbGluZyBsaXN0PGJyPgo8YSBocmVmPSJtYWlsdG86b2Zvbm9A
b2Zvbm8ub3JnIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8YSBocmVmPSJodHRwOi8vbGlzdHMu
b2Zvbm8ub3JnL2xpc3RpbmZvL29mb25vIiB0YXJnZXQ9Il9ibGFuayI+aHR0cDovL2xpc3RzLm9m
b25vLm9yZy9saXN0aW5mby9vZm9ubzwvYT48YnI+CjwvYmxvY2txdW90ZT48L2Rpdj48YnI+Cg==

--===============7480162550886063741==--

