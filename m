Content-Type: multipart/mixed; boundary="===============4952660018784322730=="
MIME-Version: 1.0
From: Ernast Sevo <ersevs@gmail.com>
Subject: Re: connection manager interface
Date: Tue, 14 Oct 2014 15:00:27 -0400
Message-ID: <CAOD0pen=wcBtCmRJw0iA40VioyRqiKN2u6F02dGv_0mk8dmDrA@mail.gmail.com>
In-Reply-To: <543BF991.2040200@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4952660018784322730==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Perfect! That clears things up a bit!
Once in the online state will the Packet Radio Service always be attached?
Ive noticed it at times that its not attached (even though packet radio use
is allowed ie Powered=3DTrue in org.ofono.ConnectionManager) and that I
cannot manually attach it which is something is doable via an AT command.
Or does calling enable gprs automatically attach it? Is there a way to
manually attach it through ofono?

Thanks again,

 Ernast

On Mon, Oct 13, 2014 at 12:10 PM, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Ernast,
>
>
> On 10/13/2014 10:51 AM, Ernast Sevo wrote:
>
>> Hello all!
>>
>> I have been playing around with ofono recently and was wondering how
>> ofono determined when to bring up the connection manager interface. I
>> know that the interfaces supported depend on the state of the device but
>> what is the state (registration status, network capabilities, etc ) at
>> which it is appropriate for the connection manager interface to be up? (
>> I am assuming here all hardware requirements for this interface are met
>> by the modem since I know this to be true, but am simply curious about
>> the external factors involved.)
>>
>>
> ConnectionManager is created by the ofono_gprs atom.  This atom can be
> created either in post_sim or post_online state.
>
> The earlier state is preferred (e.g. post_sim), but some hardware
> implementations might want to delay this until post_online for whatever
> reason.  I think the majority of oFono modem drivers initialize ofono_gprs
> in the post_sim state.
>
> Note that the functionality of ConnectionManager will be largely
> unavailable without network registration.  So you won't be able to activa=
te
> / deactivate contexts until you are registered to the network.  You can
> however manipulate context settings and other settings (e.g. in Airplane
> mode or without being registered to a network)
>
> Regards,
> -Denis
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>

--===============4952660018784322730==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PlBlcmZlY3QhIFRoYXQgY2xlYXJzIHRoaW5ncyB1cCBh
IGJpdCE8YnI+PC9kaXY+T25jZSBpbiB0aGUgb25saW5lIHN0YXRlIHdpbGwgdGhlIFBhY2tldCBS
YWRpbyBTZXJ2aWNlIGFsd2F5cyBiZSBhdHRhY2hlZD8gSXZlIG5vdGljZWQgaXQgYXQgdGltZXMg
dGhhdCBpdHMgbm90IGF0dGFjaGVkIChldmVuIHRob3VnaCBwYWNrZXQgcmFkaW8gdXNlIGlzIGFs
bG93ZWQgaWUgUG93ZXJlZD1UcnVlIGluIG9yZy5vZm9uby5Db25uZWN0aW9uTWFuYWdlcikgYW5k
IHRoYXQgSSBjYW5ub3QgbWFudWFsbHkgYXR0YWNoIGl0IHdoaWNoIGlzIHNvbWV0aGluZyBpcyBk
b2FibGUgdmlhIGFuIEFUIGNvbW1hbmQuIE9yIGRvZXMgY2FsbGluZyBlbmFibGUgZ3BycyBhdXRv
bWF0aWNhbGx5IGF0dGFjaCBpdD8gSXMgdGhlcmUgYSB3YXkgdG8gbWFudWFsbHkgYXR0YWNoIGl0
IHRocm91Z2ggb2Zvbm8/PGJyPjxicj48L2Rpdj5UaGFua3MgYWdhaW4sPGJyPjxicj7CoEVybmFz
dDxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGJyPjxkaXYgY2xhc3M9ImdtYWls
X3F1b3RlIj5PbiBNb24sIE9jdCAxMywgMjAxNCBhdCAxMjoxMCBQTSwgRGVuaXMgS2VuemlvciA8
c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpkZW5rZW56QGdtYWlsLmNvbSIgdGFy
Z2V0PSJfYmxhbmsiPmRlbmtlbnpAZ21haWwuY29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj48
YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDti
b3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij5IaSBFcm5hc3QsPGRp
dj48ZGl2IGNsYXNzPSJoNSI+PGJyPgo8YnI+Ck9uIDEwLzEzLzIwMTQgMTA6NTEgQU0sIEVybmFz
dCBTZXZvIHdyb3RlOjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0i
bWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0
OjFleCI+CkhlbGxvIGFsbCE8YnI+Cjxicj4KSSBoYXZlIGJlZW4gcGxheWluZyBhcm91bmQgd2l0
aCBvZm9ubyByZWNlbnRseSBhbmQgd2FzIHdvbmRlcmluZyBob3c8YnI+Cm9mb25vIGRldGVybWlu
ZWQgd2hlbiB0byBicmluZyB1cCB0aGUgY29ubmVjdGlvbiBtYW5hZ2VyIGludGVyZmFjZS4gSTxi
cj4Ka25vdyB0aGF0IHRoZSBpbnRlcmZhY2VzIHN1cHBvcnRlZCBkZXBlbmQgb24gdGhlIHN0YXRl
IG9mIHRoZSBkZXZpY2UgYnV0PGJyPgp3aGF0IGlzIHRoZSBzdGF0ZSAocmVnaXN0cmF0aW9uIHN0
YXR1cywgbmV0d29yayBjYXBhYmlsaXRpZXMsIGV0YyApIGF0PGJyPgp3aGljaCBpdCBpcyBhcHBy
b3ByaWF0ZSBmb3IgdGhlIGNvbm5lY3Rpb24gbWFuYWdlciBpbnRlcmZhY2UgdG8gYmUgdXA/ICg8
YnI+CkkgYW0gYXNzdW1pbmcgaGVyZSBhbGwgaGFyZHdhcmUgcmVxdWlyZW1lbnRzIGZvciB0aGlz
IGludGVyZmFjZSBhcmUgbWV0PGJyPgpieSB0aGUgbW9kZW0gc2luY2UgSSBrbm93IHRoaXMgdG8g
YmUgdHJ1ZSwgYnV0IGFtIHNpbXBseSBjdXJpb3VzIGFib3V0PGJyPgp0aGUgZXh0ZXJuYWwgZmFj
dG9ycyBpbnZvbHZlZC4pPGJyPgo8YnI+CjwvYmxvY2txdW90ZT4KPGJyPjwvZGl2PjwvZGl2PgpD
b25uZWN0aW9uTWFuYWdlciBpcyBjcmVhdGVkIGJ5IHRoZSBvZm9ub19ncHJzIGF0b20uwqAgVGhp
cyBhdG9tIGNhbiBiZSBjcmVhdGVkIGVpdGhlciBpbiBwb3N0X3NpbSBvciBwb3N0X29ubGluZSBz
dGF0ZS48YnI+Cjxicj4KVGhlIGVhcmxpZXIgc3RhdGUgaXMgcHJlZmVycmVkIChlLmcuIHBvc3Rf
c2ltKSwgYnV0IHNvbWUgaGFyZHdhcmUgaW1wbGVtZW50YXRpb25zIG1pZ2h0IHdhbnQgdG8gZGVs
YXkgdGhpcyB1bnRpbCBwb3N0X29ubGluZSBmb3Igd2hhdGV2ZXIgcmVhc29uLsKgIEkgdGhpbmsg
dGhlIG1ham9yaXR5IG9mIG9Gb25vIG1vZGVtIGRyaXZlcnMgaW5pdGlhbGl6ZSBvZm9ub19ncHJz
IGluIHRoZSBwb3N0X3NpbSBzdGF0ZS48YnI+Cjxicj4KTm90ZSB0aGF0IHRoZSBmdW5jdGlvbmFs
aXR5IG9mIENvbm5lY3Rpb25NYW5hZ2VyIHdpbGwgYmUgbGFyZ2VseSB1bmF2YWlsYWJsZSB3aXRo
b3V0IG5ldHdvcmsgcmVnaXN0cmF0aW9uLsKgIFNvIHlvdSB3b24mIzM5O3QgYmUgYWJsZSB0byBh
Y3RpdmF0ZSAvIGRlYWN0aXZhdGUgY29udGV4dHMgdW50aWwgeW91IGFyZSByZWdpc3RlcmVkIHRv
IHRoZSBuZXR3b3JrLsKgIFlvdSBjYW4gaG93ZXZlciBtYW5pcHVsYXRlIGNvbnRleHQgc2V0dGlu
Z3MgYW5kIG90aGVyIHNldHRpbmdzIChlLmcuIGluIEFpcnBsYW5lIG1vZGUgb3Igd2l0aG91dCBi
ZWluZyByZWdpc3RlcmVkIHRvIGEgbmV0d29yayk8YnI+Cjxicj4KUmVnYXJkcyw8YnI+Ci1EZW5p
czxicj4KPGJyPgo8YnI+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzx1PjwvdT5fX19f
X19fX19fX19fX19fXzxicj4Kb2Zvbm8gbWFpbGluZyBsaXN0PGJyPgo8YSBocmVmPSJtYWlsdG86
b2Zvbm9Ab2Zvbm8ub3JnIiB0YXJnZXQ9Il9ibGFuayI+b2Zvbm9Ab2Zvbm8ub3JnPC9hPjxicj4K
PGEgaHJlZj0iaHR0cHM6Ly9saXN0cy5vZm9uby5vcmcvbWFpbG1hbi9saXN0aW5mby9vZm9ubyIg
dGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vbGlzdHMub2Zvbm8ub3JnLzx1PjwvdT5tYWlsbWFuL2xp
c3RpbmZvL29mb25vPC9hPjxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48L2Rpdj4K

--===============4952660018784322730==--

