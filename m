Content-Type: multipart/mixed; boundary="===============1643517409851534357=="
MIME-Version: 1.0
From: Tomasz Gregorek <tomasz.gregorek@gmail.com>
Subject: Re: [RFC PATCH v3] gprs: add function to handle activated context
Date: Fri, 11 Feb 2011 15:08:51 +0100
Message-ID: <AANLkTimaSGuXs23p+LSocMhKdtybZcC1tyBb5Q1Qouk2@mail.gmail.com>
In-Reply-To: <8281606748F03E4390BB98A3F47F2E948A9F71E69A@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1643517409851534357==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Redouane
Find some comments below.

2011/2/9 Soum, RedouaneX <redouanex.soum@intel.com>

> The purpose of the patch is to handle Network Initiated Context Activation
> and PDN connection request as part of EPS Attach procedure (LTE) in oFono
> core.
>
> In order to avoid issue regarding CID allocation :
> - driver should call the core using ofono_gprs_set_cid_range function to
> specify CID range for UE initiated PDN connection
> - driver could use a new function to check if the CID is already used or
> not : ofono_gprs_is_cid_used, usefull in case the modem is not using a
> specific range for UE initiated PDN connection.
> - driver will use a new function to notify the gprs atom of a new PDN
> connection with all the ip parameters from AT+CGCONTRDP (I can provide an
> update later to handle PCSCF and IMS Signaling Flag as well) commmand :
> ofono_gprs_context_activated
>
> ofono_gprs_context_activated is similar to ofono_gprs_context_deactivated.
> This function must be call by any gprs driver when :
>  - a context has been activated without explicit request as part of attach
> procedure in LTE (PDN ACT X and X is a unused CID)
>  - a context has been activated by the Network (NW PDN ACT X, NW ACT X,Y)
>
> Behavior of the function :
>
> List all the context and try to find correct APN with empty username and
> empty password.
> If such context is not found then create a new one with "Internet" type
> only if we are in LTE with no Active context.
> Otherwise deactivate the connection.
>
> For the context (found or created):
>        Update the settings
>        Set to active
>
> The function will also assign the context to a context driver.
> ---
>  include/gprs-context.h |    7 +++
>  include/gprs.h         |    3 +
>  src/gprs.c             |  139
> ++++++++++++++++++++++++++++++++++++++++++++++++
>  src/idmap.c            |   12 ++++
>  src/idmap.h            |    1 +
>  5 files changed, 162 insertions(+), 0 deletions(-)
>
> diff --git a/include/gprs-context.h b/include/gprs-context.h
> index c29c0dc..e208b66 100644
> --- a/include/gprs-context.h
> +++ b/include/gprs-context.h
> @@ -76,6 +76,13 @@ struct ofono_gprs_context_driver {
>                                        ofono_gprs_context_cb_t cb, void
> *data);
>  };
>
> +
> +void ofono_gprs_context_activated(struct ofono_gprs_context *gc,
> +               const int cid, const char *apn,
> +               const char *interface, ofono_bool_t static_ip,
> +               const char *address, const char *netmask,
> +               const char *gw, const char **dns);
> +
>

When this function is called we don't know *interface yet, as it is *gc
specific.
You look for a proper *gc_driver later on.
Maybe we should address found *gc_driver for a *interface?

Also looking at incoming IPv6 patches, maybe we should consider sending
connection data with separate functions?

<snip>

Br
Tomasz Gregorek
ST-Ericsson

--===============1643517409851534357==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgUmVkb3VhbmU8YnI+RmluZCBzb21lIGNvbW1lbnRzIGJlbG93Ljxicj48YnI+PGRpdiBjbGFz
cz0iZ21haWxfcXVvdGUiPjIwMTEvMi85IFNvdW0sIFJlZG91YW5lWCA8c3BhbiBkaXI9Imx0ciI+
Jmx0OzxhIGhyZWY9Im1haWx0bzpyZWRvdWFuZXguc291bUBpbnRlbC5jb20iIHRhcmdldD0iX2Js
YW5rIj5yZWRvdWFuZXguc291bUBpbnRlbC5jb208L2E+Jmd0Ozwvc3Bhbj48YnI+PGJsb2NrcXVv
dGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOiAwcHQgMHB0IDBwdCAwLjhleDsg
Ym9yZGVyLWxlZnQ6IDFweCBzb2xpZCByZ2IoMjA0LCAyMDQsIDIwNCk7IHBhZGRpbmctbGVmdDog
MWV4OyI+CgpUaGUgcHVycG9zZSBvZiB0aGUgcGF0Y2ggaXMgdG8gaGFuZGxlIE5ldHdvcmsgSW5p
dGlhdGVkIENvbnRleHQgQWN0aXZhdGlvbiBhbmQgUEROIGNvbm5lY3Rpb24gcmVxdWVzdCBhcyBw
YXJ0IG9mIEVQUyBBdHRhY2ggcHJvY2VkdXJlIChMVEUpIGluIG9Gb25vIGNvcmUuPGJyPgo8YnI+
CkluIG9yZGVyIHRvIGF2b2lkIGlzc3VlIHJlZ2FyZGluZyBDSUQgYWxsb2NhdGlvbiA6PGJyPgot
IGRyaXZlciBzaG91bGQgY2FsbCB0aGUgY29yZSB1c2luZyBvZm9ub19ncHJzX3NldF9jaWRfcmFu
Z2UgZnVuY3Rpb24gdG8gc3BlY2lmeSBDSUQgcmFuZ2UgZm9yIFVFIGluaXRpYXRlZCBQRE4gY29u
bmVjdGlvbjxicj4KLSBkcml2ZXIgY291bGQgdXNlIGEgbmV3IGZ1bmN0aW9uIHRvIGNoZWNrIGlm
IHRoZSBDSUQgaXMgYWxyZWFkeSB1c2VkIG9yIG5vdCA6IG9mb25vX2dwcnNfaXNfY2lkX3VzZWQs
IHVzZWZ1bGwgaW4gY2FzZSB0aGUgbW9kZW0gaXMgbm90IHVzaW5nIGEgc3BlY2lmaWMgcmFuZ2Ug
Zm9yIFVFIGluaXRpYXRlZCBQRE4gY29ubmVjdGlvbi48YnI+Ci0gZHJpdmVyIHdpbGwgdXNlIGEg
bmV3IGZ1bmN0aW9uIHRvIG5vdGlmeSB0aGUgZ3BycyBhdG9tIG9mIGEgbmV3IFBETiBjb25uZWN0
aW9uIHdpdGggYWxsIHRoZSBpcCBwYXJhbWV0ZXJzIGZyb20gQVQrQ0dDT05UUkRQIChJIGNhbiBw
cm92aWRlIGFuIHVwZGF0ZSBsYXRlciB0byBoYW5kbGUgUENTQ0YgYW5kIElNUyBTaWduYWxpbmcg
RmxhZyBhcyB3ZWxsKSBjb21tbWFuZCA6IG9mb25vX2dwcnNfY29udGV4dF9hY3RpdmF0ZWQ8YnI+
CgoKPGJyPgpvZm9ub19ncHJzX2NvbnRleHRfYWN0aXZhdGVkIGlzIHNpbWlsYXIgdG8gb2Zvbm9f
Z3Byc19jb250ZXh0X2RlYWN0aXZhdGVkLjxicj4KVGhpcyBmdW5jdGlvbiBtdXN0IGJlIGNhbGwg
YnkgYW55IGdwcnMgZHJpdmVyIHdoZW4gOjxicj4KoC0gYSBjb250ZXh0IGhhcyBiZWVuIGFjdGl2
YXRlZCB3aXRob3V0IGV4cGxpY2l0IHJlcXVlc3QgYXMgcGFydCBvZiBhdHRhY2ggcHJvY2VkdXJl
IGluIExURSAoUEROIEFDVCBYIGFuZCBYIGlzIGEgdW51c2VkIENJRCk8YnI+CqAtIGEgY29udGV4
dCBoYXMgYmVlbiBhY3RpdmF0ZWQgYnkgdGhlIE5ldHdvcmsgKE5XIFBETiBBQ1QgWCwgTlcgQUNU
IFgsWSk8YnI+Cjxicj4KQmVoYXZpb3Igb2YgdGhlIGZ1bmN0aW9uIDo8YnI+Cjxicj4KTGlzdCBh
bGwgdGhlIGNvbnRleHQgYW5kIHRyeSB0byBmaW5kIGNvcnJlY3QgQVBOIHdpdGggZW1wdHkgdXNl
cm5hbWUgYW5kIGVtcHR5IHBhc3N3b3JkLjxicj4KSWYgc3VjaCBjb250ZXh0IGlzIG5vdCBmb3Vu
ZCB0aGVuIGNyZWF0ZSBhIG5ldyBvbmUgd2l0aCAmcXVvdDtJbnRlcm5ldCZxdW90OyB0eXBlIG9u
bHkgaWYgd2UgYXJlIGluIExURSB3aXRoIG5vIEFjdGl2ZSBjb250ZXh0Ljxicj4KT3RoZXJ3aXNl
IGRlYWN0aXZhdGUgdGhlIGNvbm5lY3Rpb24uPGJyPgo8YnI+CkZvciB0aGUgY29udGV4dCAoZm91
bmQgb3IgY3JlYXRlZCk6PGJyPgogoCCgIKAgoFVwZGF0ZSB0aGUgc2V0dGluZ3M8YnI+CiCgIKAg
oCCgU2V0IHRvIGFjdGl2ZTxicj4KPGJyPgpUaGUgZnVuY3Rpb24gd2lsbCBhbHNvIGFzc2lnbiB0
aGUgY29udGV4dCB0byBhIGNvbnRleHQgZHJpdmVyLjxicj4KLS0tPGJyPgqgaW5jbHVkZS9ncHJz
LWNvbnRleHQuaCB8IKAgoDcgKysrPGJyPgqgaW5jbHVkZS9ncHJzLmggoCCgIKAgoCB8IKAgoDMg
Kzxicj4KoHNyYy9ncHJzLmMgoCCgIKAgoCCgIKAgfCCgMTM5ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKzxicj4KoHNyYy9pZG1hcC5jIKAgoCCgIKAgoCCg
fCCgIDEyICsrKys8YnI+CqBzcmMvaWRtYXAuaCCgIKAgoCCgIKAgoHwgoCCgMSArPGJyPgqgNSBm
aWxlcyBjaGFuZ2VkLCAxNjIgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSk8YnI+Cjxicj4K
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvZ3Bycy1jb250ZXh0LmggYi9pbmNsdWRlL2dwcnMtY29udGV4
dC5oPGJyPgppbmRleCBjMjljMGRjLi5lMjA4YjY2IDEwMDY0NDxicj4KLS0tIGEvaW5jbHVkZS9n
cHJzLWNvbnRleHQuaDxicj4KKysrIGIvaW5jbHVkZS9ncHJzLWNvbnRleHQuaDxicj4KQEAgLTc2
LDYgKzc2LDEzIEBAIHN0cnVjdCBvZm9ub19ncHJzX2NvbnRleHRfZHJpdmVyIHs8YnI+CiCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKBvZm9ub19ncHJzX2NvbnRleHRfY2Jf
dCBjYiwgdm9pZCAqZGF0YSk7PGJyPgqgfTs8YnI+Cjxicj4KKzxicj4KK3ZvaWQgb2Zvbm9fZ3By
c19jb250ZXh0X2FjdGl2YXRlZChzdHJ1Y3Qgb2Zvbm9fZ3Byc19jb250ZXh0ICpnYyw8YnI+Cisg
oCCgIKAgoCCgIKAgoCBjb25zdCBpbnQgY2lkLCBjb25zdCBjaGFyICphcG4sPGJyPgorIKAgoCCg
IKAgoCCgIKAgY29uc3QgY2hhciAqaW50ZXJmYWNlLCBvZm9ub19ib29sX3Qgc3RhdGljX2lwLDxi
cj4KKyCgIKAgoCCgIKAgoCCgIGNvbnN0IGNoYXIgKmFkZHJlc3MsIGNvbnN0IGNoYXIgKm5ldG1h
c2ssPGJyPgorIKAgoCCgIKAgoCCgIKAgY29uc3QgY2hhciAqZ3csIGNvbnN0IGNoYXIgKipkbnMp
Ozxicj4KKzxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+V2hlbiB0aGlzIGZ1bmN0aW9uIGlzIGNh
bGxlZCB3ZSBkb24mIzM5O3Qga25vdyAqaW50ZXJmYWNlIHlldCwgYXMgaXQgaXMgKmdjIHNwZWNp
ZmljLjxicj5Zb3UgbG9vayBmb3IgYSBwcm9wZXIgKmdjX2RyaXZlciBsYXRlciBvbi48YnI+TWF5
YmUgd2Ugc2hvdWxkIGFkZHJlc3MgZm91bmQgKmdjX2RyaXZlciBmb3IgYSAqaW50ZXJmYWNlPzxi
cj4KCjxicj5BbHNvIGxvb2tpbmcgYXQgaW5jb21pbmcgSVB2NiBwYXRjaGVzLCBtYXliZSB3ZSBz
aG91bGQgY29uc2lkZXIgc2VuZGluZyA8YnI+Y29ubmVjdGlvbiBkYXRhIHdpdGggc2VwYXJhdGUg
ZnVuY3Rpb25zPzxicj48YnI+Jmx0O3NuaXAmZ3Q7PGJyPjwvZGl2PjwvZGl2Pjxicj5Ccjxicj5U
b21hc3ogR3JlZ29yZWs8YnI+U1QtRXJpY3Nzb248YnI+Cg==

--===============1643517409851534357==--

