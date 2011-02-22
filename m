Content-Type: multipart/mixed; boundary="===============1403058315391047547=="
MIME-Version: 1.0
From: Tomasz Gregorek <tomasz.gregorek@gmail.com>
Subject: Re: [PATCH] atmodem: CEREG support for LTE network status reporting
 in AT modem
Date: Tue, 22 Feb 2011 15:09:03 +0100
Message-ID: <AANLkTikHRFPigctx=W=KsyKUBrnFFh=k5yVBa1-c_aoh@mail.gmail.com>
In-Reply-To: <AA48DD8077D5D945A49BD1782C1140F1E7BDE3@fioues08.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1403058315391047547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vijay

2011/2/22 <Vijay.Nayani@elektrobit.com>

>
>
> > Subject: [PATCH] atmodem: CEREG support for LTE network
> > status reporting in AT modem
> >
> > [PATCH] atmodem: CEREG support for LTE network status
> > reporting in AT modem Tomasz Gregorek tomasz.gregorek at
> > gmail.com Thu Feb 17 19:52:45 PST 2011
> >
> >     * Previous message: [PATCH 2/5] bluetooth: add a
> > bluetoothd connect watch
> >     * Next message: Problem with SIM lock states not showing
> > correctly in Ofono API.
> >     * Messages sorted by: [ date ] [ thread ] [ subject ] [ author ]
> >
> > From: Tomasz Gregorek <tomasz.gregorek@stericsson.com>
> >
> > This is a proposal for CEREG support based on the AT modem.
> > Support in driver should work, though I have an issue with the core.
> >
> > The core has one gprs status currently. In case of having
> > second status for LTE, there is need of having two satuses,
> > one for each, 3G and LTE, or to combine those two into one.
> >
> > I took second approach as it leaves current oFono API, though
> > it is not perfect.
>
> I have been working on solution that comprises of separate eps atom and
> corresponding driver. Code has been tested against modified phonesim for
> eps.Will provide an RFC patch soon once I bring it to certain logical
> end.
>
> Regards,
> Vijay
>

This is what I was thinking about too.
For me, from status point of view, both networks look very similar,
thats why I was thinking about using gprs atom / driver for
status handling and create separate atom for QoS / IMS.

I am at most interested in your solution. I know from Denis that
this is what was agreed.

Br
Tomasz Gregorek

--===============1403058315391047547==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgVmlqYXk8YnI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj4yMDExLzIvMjIgIDxzcGFu
IGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOlZpamF5Lk5heWFuaUBlbGVrdHJvYml0LmNv
bSI+VmlqYXkuTmF5YW5pQGVsZWt0cm9iaXQuY29tPC9hPiZndDs8L3NwYW4+PGJyPjxibG9ja3F1
b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjogMHB0IDBwdCAwcHQgMC44ZXg7
IGJvcmRlci1sZWZ0OiAxcHggc29saWQgcmdiKDIwNCwgMjA0LCAyMDQpOyBwYWRkaW5nLWxlZnQ6
IDFleDsiPgo8YnI+Cjxicj4KJmd0OyBTdWJqZWN0OiBbUEFUQ0hdIGF0bW9kZW06IENFUkVHIHN1
cHBvcnQgZm9yIExURSBuZXR3b3JrPGJyPgomZ3Q7IHN0YXR1cyByZXBvcnRpbmcgaW4gQVQgbW9k
ZW08YnI+CiZndDs8YnI+CiZndDsgW1BBVENIXSBhdG1vZGVtOiBDRVJFRyBzdXBwb3J0IGZvciBM
VEUgbmV0d29yayBzdGF0dXM8YnI+CiZndDsgcmVwb3J0aW5nIGluIEFUIG1vZGVtIFRvbWFzeiBH
cmVnb3JlayB0b21hc3ouZ3JlZ29yZWsgYXQ8YnI+CiZndDsgPGEgaHJlZj0iaHR0cDovL2dtYWls
LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmdtYWlsLmNvbTwvYT4gVGh1IEZlYiAxNyAxOTo1Mjo0NSBQ
U1QgMjAxMTxicj4KJmd0Ozxicj4KJmd0OyCgIKAgKiBQcmV2aW91cyBtZXNzYWdlOiBbUEFUQ0gg
Mi81XSBibHVldG9vdGg6IGFkZCBhPGJyPgomZ3Q7IGJsdWV0b290aGQgY29ubmVjdCB3YXRjaDxi
cj4KJmd0OyCgIKAgKiBOZXh0IG1lc3NhZ2U6IFByb2JsZW0gd2l0aCBTSU0gbG9jayBzdGF0ZXMg
bm90IHNob3dpbmc8YnI+CiZndDsgY29ycmVjdGx5IGluIE9mb25vIEFQSS48YnI+CiZndDsgoCCg
ICogTWVzc2FnZXMgc29ydGVkIGJ5OiBbIGRhdGUgXSBbIHRocmVhZCBdIFsgc3ViamVjdCBdIFsg
YXV0aG9yIF08YnI+CiZndDs8YnI+CiZndDsgRnJvbTogVG9tYXN6IEdyZWdvcmVrICZsdDt0b21h
c3ouZ3JlZ29yZWsgYXQgPGEgaHJlZj0iaHR0cDovL3N0ZXJpY3Nzb24uY29tIiB0YXJnZXQ9Il9i
bGFuayI+c3Rlcmljc3Nvbi5jb208L2E+Jmd0Ozxicj4KPGRpdiBjbGFzcz0iaW0iPiZndDs8YnI+
CiZndDsgVGhpcyBpcyBhIHByb3Bvc2FsIGZvciBDRVJFRyBzdXBwb3J0IGJhc2VkIG9uIHRoZSBB
VCBtb2RlbS48YnI+CiZndDsgU3VwcG9ydCBpbiBkcml2ZXIgc2hvdWxkIHdvcmssIHRob3VnaCBJ
IGhhdmUgYW4gaXNzdWUgd2l0aCB0aGUgY29yZS48YnI+CiZndDs8YnI+CiZndDsgVGhlIGNvcmUg
aGFzIG9uZSBncHJzIHN0YXR1cyBjdXJyZW50bHkuIEluIGNhc2Ugb2YgaGF2aW5nPGJyPgomZ3Q7
IHNlY29uZCBzdGF0dXMgZm9yIExURSwgdGhlcmUgaXMgbmVlZCBvZiBoYXZpbmcgdHdvIHNhdHVz
ZXMsPGJyPgomZ3Q7IG9uZSBmb3IgZWFjaCwgM0cgYW5kIExURSwgb3IgdG8gY29tYmluZSB0aG9z
ZSB0d28gaW50byBvbmUuPGJyPgomZ3Q7PGJyPgomZ3Q7IEkgdG9vayBzZWNvbmQgYXBwcm9hY2gg
YXMgaXQgbGVhdmVzIGN1cnJlbnQgb0Zvbm8gQVBJLCB0aG91Z2g8YnI+CiZndDsgaXQgaXMgbm90
IHBlcmZlY3QuPGJyPgo8YnI+CjwvZGl2PkkgaGF2ZSBiZWVuIHdvcmtpbmcgb24gc29sdXRpb24g
dGhhdCBjb21wcmlzZXMgb2Ygc2VwYXJhdGUgZXBzIGF0b20gYW5kPGJyPgpjb3JyZXNwb25kaW5n
IGRyaXZlci4gQ29kZSBoYXMgYmVlbiB0ZXN0ZWQgYWdhaW5zdCBtb2RpZmllZCBwaG9uZXNpbSBm
b3I8YnI+CmVwcy5XaWxsIHByb3ZpZGUgYW4gUkZDIHBhdGNoIHNvb24gb25jZSBJIGJyaW5nIGl0
IHRvIGNlcnRhaW4gbG9naWNhbDxicj4KZW5kLjxicj4KPGJyPgpSZWdhcmRzLDxicj4KVmlqYXk8
YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPlRoaXMgaXMgd2hhdCBJIHdhcyB0aGlua2luZyBhYm91
dCB0b28uPGJyPkZvciBtZSwgZnJvbSBzdGF0dXOgcG9pbnQgb2YgdmlldywgYm90aCBuZXR3b3Jr
cyBsb29rIHZlcnkgc2ltaWxhciw8YnI+dGhhdHMgd2h5IEkgd2FzIHRoaW5raW5nIGFib3V0IHVz
aW5nIGdwcnMgYXRvbSAvIGRyaXZlciBmb3I8YnI+c3RhdHVzIGhhbmRsaW5nIGFuZCBjcmVhdGUg
c2VwYXJhdGUgYXRvbSBmb3IgUW9TIC8gSU1TLjxicj4KPGJyPkkgYW0gYXQgbW9zdCBpbnRlcmVz
dGVkIGluIHlvdXIgc29sdXRpb24uIEkga25vdyBmcm9tIERlbmlzIHRoYXQ8YnI+dGhpcyBpcyB3
aGF0IHdhcyBhZ3JlZWQuPGJyPjxicj5Ccjxicj5Ub21hc3ogR3JlZ29yZWs8L2Rpdj48L2Rpdj4K

--===============1403058315391047547==--

