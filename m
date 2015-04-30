Content-Type: multipart/mixed; boundary="===============0404882222563523380=="
MIME-Version: 1.0
From: Alex J Lennon <ajlennon@dynamicdevices.co.uk>
Subject: Re: Cinterion EHS6 support
Date: Thu, 30 Apr 2015 11:20:39 +0200
Message-ID: <5541F3E7.2090402@dynamicdevices.co.uk>
In-Reply-To: <5541B2D2.6070606@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0404882222563523380==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 30/04/2015 06:42, Alex J Lennon wrote:
>
> On 30/04/2015 00:57, Denis Kenzior wrote:
>> Hi Alex,
>>
>>> It looks as though the issue is that the Cinterion parts don't support
>>> signal strength via +CIND ?
>> Yes, we look for "signal" indicator inside cind_support_cb.  If it
>> isn't found, then we raise an error.  This tells the hw integrator to
>> address the issue.  CIND logic is provided as a fallback / default
>> since many manufacturers support this indicator for HFP.
>>
>> signal_strength (and hence +CSQ) is used to bootstrap the signal
>> strength value.  This driver method is only called at very specific
>> times.  The core does not poll signal_strength.  It is expected that
>> the driver will send signal strength value to the core periodically,
>> by whatever means is optimal for the hardware.  Most modems use a
>> custom unsolicited notification or CIND to provide information about
>> signal strength automatically.  I suspect Cinterion has a similar
>> extension.
>>
>> The consequence of the above is that it can't.  If no vendor extension
>> is available for unsolicited notifications and signal strength is not
>> provided via CIND, then the netreg atom driver can either poll signal
>> strength manually or simply not provide any signal strength updates.
>> For the latter, it must enable such behavior explicitly.  Hence why
>> your patch providing OFONO_VENDOR_CINTERION logic makes this work
>> properly.
>>
>> Hope that made sense.
> OK thanks for explaining that Denis. Yes, I was wondering if this was
> related to the potential asynchronous nature of +CIND reporting versus
> polling via at_signal_strength()
>
> So, to make sure I understand...
>
> The error message flags up a problem for the integrator. In the case of
> OFONO_VENDOR_NOKIA, OFONO_VENDOR_SAMSUNG in at_creg_set_cb() we can
> assume this has been investigated, and no good alternative event
> reporting solution is available (or a choice was made not to implement)
> so this is disabled.
>
> However there remains an exercise to go through for Cinterion to check
> whether non-CIND reporting mechanism is available and enable it? If so
> I'll have a look through the documentation.
>
> On a separate but related note, can you tell me if ofono supports
> monitoring of signal strength whilst a data connection is up, e.g. via
> use of GSM 07.10  or with modems such as Cinterion that expose multiple
> virtual ports over USB?

Dennis,

I've had some feedback from the Cinterion guys now. The suggestion is
that there are around 12 years of development between the TC6x and the
EHSx, different chipsets, 2G vs 3G, and so there are substantial
differences between the products.

It seems as though it might be worth separating out? I'm agnostic about
the approach though. Can you let me know what you'd prefer?

Thanks, Alex
=20

--===============0404882222563523380==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9d2lu
ZG93cy0xMjUyIgogICAgICBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiPgogICAgPGxpbmsgaHJl
Zj0iY2hyb21lOi8vdHJhbnNsYXRvci9za2luL2Zsb2F0aW5nUGFuZWwuY3NzIgogICAgICB0eXBl
PSJ0ZXh0L2NzcyIgcmVsPSJzdHlsZXNoZWV0Ij4KICA8L2hlYWQ+CiAgPGJvZHkgYmdjb2xvcj0i
I0ZGRkZGRiIgdGV4dD0iIzAwMDAwMCI+CiAgICA8YnI+CiAgICA8YnI+CiAgICA8ZGl2IGNsYXNz
PSJtb3otY2l0ZS1wcmVmaXgiPk9uIDMwLzA0LzIwMTUgMDY6NDIsIEFsZXggSiBMZW5ub24KICAg
ICAgd3JvdGU6PGJyPgogICAgPC9kaXY+CiAgICA8YmxvY2txdW90ZSBjaXRlPSJtaWQ6NTU0MUIy
RDIuNjA3MDYwNkBkeW5hbWljZGV2aWNlcy5jby51ayIKICAgICAgdHlwZT0iY2l0ZSI+CiAgICAg
IDxwcmUgd3JhcD0iIj4KCk9uIDMwLzA0LzIwMTUgMDA6NTcsIERlbmlzIEtlbnppb3Igd3JvdGU6
CjwvcHJlPgogICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICA8cHJlIHdyYXA9
IiI+SGkgQWxleCwKCjwvcHJlPgogICAgICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPgogICAg
ICAgICAgPHByZSB3cmFwPSIiPgpJdCBsb29rcyBhcyB0aG91Z2ggdGhlIGlzc3VlIGlzIHRoYXQg
dGhlIENpbnRlcmlvbiBwYXJ0cyBkb24ndCBzdXBwb3J0CnNpZ25hbCBzdHJlbmd0aCB2aWEgK0NJ
TkQgPwo8L3ByZT4KICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgPHByZSB3cmFwPSIiPgpZ
ZXMsIHdlIGxvb2sgZm9yICJzaWduYWwiIGluZGljYXRvciBpbnNpZGUgY2luZF9zdXBwb3J0X2Ni
LiAgSWYgaXQKaXNuJ3QgZm91bmQsIHRoZW4gd2UgcmFpc2UgYW4gZXJyb3IuICBUaGlzIHRlbGxz
IHRoZSBodyBpbnRlZ3JhdG9yIHRvCmFkZHJlc3MgdGhlIGlzc3VlLiAgQ0lORCBsb2dpYyBpcyBw
cm92aWRlZCBhcyBhIGZhbGxiYWNrIC8gZGVmYXVsdApzaW5jZSBtYW55IG1hbnVmYWN0dXJlcnMg
c3VwcG9ydCB0aGlzIGluZGljYXRvciBmb3IgSEZQLgoKc2lnbmFsX3N0cmVuZ3RoIChhbmQgaGVu
Y2UgK0NTUSkgaXMgdXNlZCB0byBib290c3RyYXAgdGhlIHNpZ25hbApzdHJlbmd0aCB2YWx1ZS4g
IFRoaXMgZHJpdmVyIG1ldGhvZCBpcyBvbmx5IGNhbGxlZCBhdCB2ZXJ5IHNwZWNpZmljCnRpbWVz
LiAgVGhlIGNvcmUgZG9lcyBub3QgcG9sbCBzaWduYWxfc3RyZW5ndGguICBJdCBpcyBleHBlY3Rl
ZCB0aGF0CnRoZSBkcml2ZXIgd2lsbCBzZW5kIHNpZ25hbCBzdHJlbmd0aCB2YWx1ZSB0byB0aGUg
Y29yZSBwZXJpb2RpY2FsbHksCmJ5IHdoYXRldmVyIG1lYW5zIGlzIG9wdGltYWwgZm9yIHRoZSBo
YXJkd2FyZS4gIE1vc3QgbW9kZW1zIHVzZSBhCmN1c3RvbSB1bnNvbGljaXRlZCBub3RpZmljYXRp
b24gb3IgQ0lORCB0byBwcm92aWRlIGluZm9ybWF0aW9uIGFib3V0CnNpZ25hbCBzdHJlbmd0aCBh
dXRvbWF0aWNhbGx5LiAgSSBzdXNwZWN0IENpbnRlcmlvbiBoYXMgYSBzaW1pbGFyCmV4dGVuc2lv
bi4KClRoZSBjb25zZXF1ZW5jZSBvZiB0aGUgYWJvdmUgaXMgdGhhdCBpdCBjYW4ndC4gIElmIG5v
IHZlbmRvciBleHRlbnNpb24KaXMgYXZhaWxhYmxlIGZvciB1bnNvbGljaXRlZCBub3RpZmljYXRp
b25zIGFuZCBzaWduYWwgc3RyZW5ndGggaXMgbm90CnByb3ZpZGVkIHZpYSBDSU5ELCB0aGVuIHRo
ZSBuZXRyZWcgYXRvbSBkcml2ZXIgY2FuIGVpdGhlciBwb2xsIHNpZ25hbApzdHJlbmd0aCBtYW51
YWxseSBvciBzaW1wbHkgbm90IHByb3ZpZGUgYW55IHNpZ25hbCBzdHJlbmd0aCB1cGRhdGVzLgpG
b3IgdGhlIGxhdHRlciwgaXQgbXVzdCBlbmFibGUgc3VjaCBiZWhhdmlvciBleHBsaWNpdGx5LiAg
SGVuY2Ugd2h5CnlvdXIgcGF0Y2ggcHJvdmlkaW5nIE9GT05PX1ZFTkRPUl9DSU5URVJJT04gbG9n
aWMgbWFrZXMgdGhpcyB3b3JrCnByb3Blcmx5LgoKSG9wZSB0aGF0IG1hZGUgc2Vuc2UuCjwvcHJl
PgogICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgIDxwcmUgd3JhcD0iIj4KT0sgdGhhbmtzIGZvciBl
eHBsYWluaW5nIHRoYXQgRGVuaXMuIFllcywgSSB3YXMgd29uZGVyaW5nIGlmIHRoaXMgd2FzCnJl
bGF0ZWQgdG8gdGhlIHBvdGVudGlhbCBhc3luY2hyb25vdXMgbmF0dXJlIG9mICtDSU5EIHJlcG9y
dGluZyB2ZXJzdXMKcG9sbGluZyB2aWEgYXRfc2lnbmFsX3N0cmVuZ3RoKCkKClNvLCB0byBtYWtl
IHN1cmUgSSB1bmRlcnN0YW5kLi4uCgpUaGUgZXJyb3IgbWVzc2FnZSBmbGFncyB1cCBhIHByb2Js
ZW0gZm9yIHRoZSBpbnRlZ3JhdG9yLiBJbiB0aGUgY2FzZSBvZgpPRk9OT19WRU5ET1JfTk9LSUEs
IE9GT05PX1ZFTkRPUl9TQU1TVU5HIGluIGF0X2NyZWdfc2V0X2NiKCkgd2UgY2FuCmFzc3VtZSB0
aGlzIGhhcyBiZWVuIGludmVzdGlnYXRlZCwgYW5kIG5vIGdvb2QgYWx0ZXJuYXRpdmUgZXZlbnQK
cmVwb3J0aW5nIHNvbHV0aW9uIGlzIGF2YWlsYWJsZSAob3IgYSBjaG9pY2Ugd2FzIG1hZGUgbm90
IHRvIGltcGxlbWVudCkKc28gdGhpcyBpcyBkaXNhYmxlZC4KCkhvd2V2ZXIgdGhlcmUgcmVtYWlu
cyBhbiBleGVyY2lzZSB0byBnbyB0aHJvdWdoIGZvciBDaW50ZXJpb24gdG8gY2hlY2sKd2hldGhl
ciBub24tQ0lORCByZXBvcnRpbmcgbWVjaGFuaXNtIGlzIGF2YWlsYWJsZSBhbmQgZW5hYmxlIGl0
PyBJZiBzbwpJJ2xsIGhhdmUgYSBsb29rIHRocm91Z2ggdGhlIGRvY3VtZW50YXRpb24uCgpPbiBh
IHNlcGFyYXRlIGJ1dCByZWxhdGVkIG5vdGUsIGNhbiB5b3UgdGVsbCBtZSBpZiBvZm9ubyBzdXBw
b3J0cwptb25pdG9yaW5nIG9mIHNpZ25hbCBzdHJlbmd0aCB3aGlsc3QgYSBkYXRhIGNvbm5lY3Rp
b24gaXMgdXAsIGUuZy4gdmlhCnVzZSBvZiBHU00gMDcuMTAgIG9yIHdpdGggbW9kZW1zIHN1Y2gg
YXMgQ2ludGVyaW9uIHRoYXQgZXhwb3NlIG11bHRpcGxlCnZpcnR1YWwgcG9ydHMgb3ZlciBVU0I/
CjwvcHJlPgogICAgPC9ibG9ja3F1b3RlPgogICAgPGJyPgogICAgRGVubmlzLDxicj4KICAgIDxi
cj4KICAgIEkndmUgaGFkIHNvbWUgZmVlZGJhY2sgZnJvbSB0aGUgQ2ludGVyaW9uIGd1eXMgbm93
LiBUaGUgc3VnZ2VzdGlvbgogICAgaXMgdGhhdCB0aGVyZSBhcmUgYXJvdW5kIDEyIHllYXJzIG9m
IGRldmVsb3BtZW50IGJldHdlZW4gdGhlIFRDNngKICAgIGFuZCB0aGUgRUhTeCwgZGlmZmVyZW50
IGNoaXBzZXRzLCAyRyB2cyAzRywgYW5kIHNvIHRoZXJlIGFyZQogICAgc3Vic3RhbnRpYWwgZGlm
ZmVyZW5jZXMgYmV0d2VlbiB0aGUgcHJvZHVjdHMuPGJyPgogICAgPGJyPgogICAgSXQgc2VlbXMg
YXMgdGhvdWdoIGl0IG1pZ2h0IGJlIHdvcnRoIHNlcGFyYXRpbmcgb3V0PyBJJ20gYWdub3N0aWMK
ICAgIGFib3V0IHRoZSBhcHByb2FjaCB0aG91Z2guIENhbiB5b3UgbGV0IG1lIGtub3cgd2hhdCB5
b3UnZCBwcmVmZXI/PGJyPgogICAgPGJyPgogICAgVGhhbmtzLCBBbGV4PGJyPgogICAgoDxicj4K
ICAgIDxkaXYgY2xhc3M9Im1vei1zaWduYXR1cmUiPgogICAgICA8ZGl2IGNsYXNzPSJwcmV2aWV3
Ij4gPC9kaXY+CiAgICA8L2Rpdj4KICAgIDxkaXYgc3R5bGU9ImJvdHRvbTogYXV0bzsgbGVmdDog
NDg4cHg7IHJpZ2h0OiBhdXRvOyB0b3A6IDcyM3B4OyIKICAgICAgY2xhc3M9InRyYW5zbGF0b3It
dGhlbWUtZGVmYXVsdCIgaWQ9InRyYW5zbGF0b3ItZmxvYXRpbmctcGFuZWwiPgogICAgICA8ZGl2
IHRpdGxlPSJDbGljayB0byB0cmFuc2xhdGUiCiAgICAgICAgaWQ9InRyYW5zbGF0b3ItZmxvYXRp
bmctcGFuZWwtYnV0dG9uIj48L2Rpdj4KICAgIDwvZGl2PgogIDwvYm9keT4KPC9odG1sPgo=

--===============0404882222563523380==--

