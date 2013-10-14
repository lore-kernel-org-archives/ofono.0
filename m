Content-Type: multipart/mixed; boundary="===============5787881663004001281=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: Re: [PATCH] plugins,
 mbpi: make mbpi return only APNs of a given type. When provisioning
 for internect connection,
 only OFONO_GPRS_CONTEXT_TYPE_INTERNET APNs will be returned.
Date: Mon, 14 Oct 2013 09:33:29 +0200
Message-ID: <CACM4vuCfS2dkpTSO4HBHVRWL_o_zoj+P+TWcwkmAbvSQerJQxw@mail.gmail.com>
In-Reply-To: <52582EB3.2040004@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5787881663004001281==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,


The patch is related to the following bug:
>>
>> https://bugs.launchpad.net/**ubuntu/+source/ofono/+bug/**1222106<https:/=
/bugs.launchpad.net/ubuntu/+source/ofono/+bug/1222106>
>>
>> So we were obtaining some times settings for the MMS APN instead of the
>> internet one. Maybe the change makes it work only for internet
>> connection, but not for MMS. Would that mean that get_settings() should
>> have a parameter specifying the context type so the user decides?
>>
>>
> The mbpi parser will assign a context type to the provisioned context
> based on the "type" attribute inside mobile-broadband-provider-**info.
>  So assuming the parser is working correctly, the context will be labeled
> accordingly in oFono on the D-Bus API level.
>
> The parser works by returning all contexts that match a particular mcc/mnc
> if and only if no conflicts or multiple matches are found. Since you're
> saying it picks the 'wrong' one, then I assume the issue is inside your
> application, not oFono.
>

After gathering some more information, I think that the problem comes from
different behaviors of connman vs NetworkManager when handling the context.
So we need to re-think this on our side.

Thanks for your comments,
Alfonso

--===============5787881663004001281==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgRGVuaXMsPGJyPjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+
PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtw
YWRkaW5nLWxlZnQ6MWV4Ij48ZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5
bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmct
bGVmdDoxZXgiPgoKClRoZSBwYXRjaCBpcyByZWxhdGVkIHRvIHRoZSBmb2xsb3dpbmcgYnVnOjxi
cj4KPGJyPgo8YSBocmVmPSJodHRwczovL2J1Z3MubGF1bmNocGFkLm5ldC91YnVudHUvK3NvdXJj
ZS9vZm9uby8rYnVnLzEyMjIxMDYiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2J1Z3MubGF1bmNo
cGFkLm5ldC88dT48L3U+dWJ1bnR1Lytzb3VyY2Uvb2Zvbm8vK2J1Zy88dT48L3U+MTIyMjEwNjwv
YT48YnI+Cjxicj4KU28gd2Ugd2VyZSBvYnRhaW5pbmcgc29tZSB0aW1lcyBzZXR0aW5ncyBmb3Ig
dGhlIE1NUyBBUE4gaW5zdGVhZCBvZiB0aGU8YnI+CmludGVybmV0IG9uZS4gTWF5YmUgdGhlIGNo
YW5nZSBtYWtlcyBpdCB3b3JrIG9ubHkgZm9yIGludGVybmV0PGJyPgpjb25uZWN0aW9uLCBidXQg
bm90IGZvciBNTVMuIFdvdWxkIHRoYXQgbWVhbiB0aGF0IGdldF9zZXR0aW5ncygpIHNob3VsZDxi
cj4KaGF2ZSBhIHBhcmFtZXRlciBzcGVjaWZ5aW5nIHRoZSBjb250ZXh0IHR5cGUgc28gdGhlIHVz
ZXIgZGVjaWRlcz88YnI+Cjxicj4KPC9ibG9ja3F1b3RlPgo8YnI+PC9kaXY+ClRoZSBtYnBpIHBh
cnNlciB3aWxsIGFzc2lnbiBhIGNvbnRleHQgdHlwZSB0byB0aGUgcHJvdmlzaW9uZWQgY29udGV4
dCBiYXNlZCBvbiB0aGUgJnF1b3Q7dHlwZSZxdW90OyBhdHRyaWJ1dGUgaW5zaWRlIG1vYmlsZS1i
cm9hZGJhbmQtcHJvdmlkZXItPHU+PC91PmluZm8uIKBTbyBhc3N1bWluZyB0aGUgcGFyc2VyIGlz
IHdvcmtpbmcgY29ycmVjdGx5LCB0aGUgY29udGV4dCB3aWxsIGJlIGxhYmVsZWQgYWNjb3JkaW5n
bHkgaW4gb0Zvbm8gb24gdGhlIEQtQnVzIEFQSSBsZXZlbC48YnI+CgoKPGJyPgpUaGUgcGFyc2Vy
IHdvcmtzIGJ5IHJldHVybmluZyBhbGwgY29udGV4dHMgdGhhdCBtYXRjaCBhIHBhcnRpY3VsYXIg
bWNjL21uYyBpZiBhbmQgb25seSBpZiBubyBjb25mbGljdHMgb3IgbXVsdGlwbGUgbWF0Y2hlcyBh
cmUgZm91bmQuIFNpbmNlIHlvdSYjMzk7cmUgc2F5aW5nIGl0IHBpY2tzIHRoZSAmIzM5O3dyb25n
JiMzOTsgb25lLCB0aGVuIEkgYXNzdW1lIHRoZSBpc3N1ZSBpcyBpbnNpZGUgeW91ciBhcHBsaWNh
dGlvbiwgbm90IG9Gb25vLjxicj4KCjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PkFm
dGVyIGdhdGhlcmluZyBzb21lIG1vcmUgaW5mb3JtYXRpb24sIEkgdGhpbmsgdGhhdCB0aGUgcHJv
YmxlbSBjb21lcyBmcm9tIGRpZmZlcmVudCBiZWhhdmlvcnMgb2YgY29ubm1hbiB2cyBOZXR3b3Jr
TWFuYWdlciB3aGVuIGhhbmRsaW5nIHRoZSBjb250ZXh0LiBTbyB3ZSBuZWVkIHRvIHJlLXRoaW5r
IHRoaXMgb24gb3VyIHNpZGUuPC9kaXY+CjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmtzIGZvciB5
b3VyIGNvbW1lbnRzLDwvZGl2PjxkaXY+QWxmb25zbzwvZGl2PjwvZGl2Pjxicj48L2Rpdj48L2Rp
dj4K

--===============5787881663004001281==--

