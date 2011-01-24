Content-Type: multipart/mixed; boundary="===============8250563148108776568=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: Re: SAT support in oFono
Date: Mon, 24 Jan 2011 14:58:36 +0000
Message-ID: <4D3D9394.7050803@linux.intel.com>
In-Reply-To: <1295866144.2676.15.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8250563148108776568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 01/24/2011 11:49 AM, Marcel Holtmann wrote:
> Hi Lasse,
>
>>>> I am checking what is the level of SAT/STK support in ofono and have a=
 couple of questions. The current implementation contains support for basic=
 STK commands, like menus, inputs, calls, sms and so on. In TODO, there is =
only REFRESH command on the list.
>>>>
>>>> Is there plans or ideas to extend the support in oFono Core with more =
complex STK features like (3GPP TS 31.111):
>>>> - Call control by USIM
>>>> - MO SMS Control by USIM
>>> Let us set aside the the merits of the use cases for these features for
>>> the moment ;)  Implementing Call control by USIM is fairly
>>> straightforward to do in the core.  However, no modem manufacturer
>>> currently allows us to have full control over this feature.  It is
>>> implemented in the firmware and every vendor does this differently.  So
>>> for now support of this feature is in the realm of the modem driver.
>>>
>> okay, so assuming this is how it is going stay. Even modem handles
>> these, ofono should deliver possible AlphaId SIM may give in a response
>> to call control envelope. I did not see if this is implemented. Or is it
>> dropped since it is not tested in GCF..
> show us modem hardware where this is needed. At some point we just had
> to be realistic here in what can be tested with real hardware. And thus
> is really required to be supported and what makes sense in a smartphone
> environment.
>
>>>> - BIP (Bearer independent protocol), including commands like OPEN CHAN=
NEL, CLOSE CHANNEL, SEND/RECEIVE DATA
>> BIP is on many operators' wish list of supported SAT features. Even it
>> is optional in 3GPP, some market areas will probably require BIP. I
>> don't have an example to give right now.
> I think the important phrase is "wish list". So far nobody could really
> showed me the exact use case for BIP. I am actually really interested in
> understanding what the operators wanna use it for. I prefer to have hard
> facts here and not just "wish list" and "probably". If this is not a
> requirement for certification and the operator is not actually using
> such a feature at all, then why bother. Feel free to convince me
> otherwise here.
>
> While we can certainly look into supporting BIP at some point, but from
> where I am standing it is pretty clear; first get all mandatory STK
> features sorted out, before trying to work on optional ones.
>
>>>> - Extend support in PROVIDE LOCAL INFO
>>> What support are you looking for?  Most of the information that is asked
>>> by provide local info is implemented in the modem firmware.  We have
>>> only included support for items which are not covered by the firmware.
>>>
>> If aiming GCF approval support should contain: IMEI, location info,
>> network measurements&BCCH channel list, timing advance, access
>> technology, IMEISV, Inter-frequency UTRAN measurements. As you said
>> these are often handled by modem, but isn't possible that modem can be
>> configured in a way it leaves the full control of SAT to the host?
>> Although certain AT command based modems would require proprietary
>> commands to fetch all the needed information. So in that sense it is
>> more logical for modem to handle these commands what requires low level
>> interfaces.
> What we have seen so far is that all of these are handled by the modem.
> If the modem has all information available, then why bother waking up
> the host CPU for this. It does make a lot of sense to keep the host CPU
> asleep if possible. I am pretty pragmatic here; if we have to support a
> modem that does not handle these, then we have to do it.
>
> So if you have more information about other modem types, please let us
> know. And patches are always welcome.
>
>>>> - EVENT DOWNLOAD / SET UP EVENT LIST
>>>>
>>> Again, which ones are you looking for?  oFono explicitly ignores the
>>> following two events as these make no sense in the smartphone context:
>>>
>>> - Idle Screen Available
>>> - User Activity
>>>
>> It looks like  Idle Screen Available and User Activity&  User Activity
>> are mandatory features in 3GPP TS 31.124, chapter 3.4 Applicability
>> table. Rest of the sub-features are listed there.
> Don't they depend on the STK profile that you are using?
>

Apparently, the answer (shall we support or not those UI events ?) seems =

to be also linked to which release we are claiming to comply with the =

product.

Indeed, according the conformance specification 31.124, the tests =

related to the events are described as follows:
*
Table B.1: Applicability of tests*
---------------------------------------------------------------------------=
-------------------------------------------------------------------------- =


|           Item description                        |  Whatever is the =

release  |                            =

Profile                                        |
---------------------------------------------------------------------------=
--------------------------------------------------------------------------
| 27.22.7.5: user activity event                | C178                   =

          | E.1/38 AND E.1/33 AND E.1/111                          |
---------------------------------------------------------------------------=
--------------------------------------------------------------------------
| 27.22.7.6: idle screen available event    | C177 AND C178            | =

E.1/39 AND E.1/33 AND E.1/110 AND E.1/111      |
---------------------------------------------------------------------------=
---------------------------------------------------------------------------
C177 =3D IF A.1/84 THEN M ELSE N/A
C178 =3D IF A.1/85 THEN M ELSE N/A*

Table A.1: Options*
---------------------------------------------------------------------------=
---------------- =


|  Item       |    Option                                          |     =

status      |
---------------------------------------------------------------------------=
---------------- =


|     A1.84  | Terminal supports display capability  | C002       |
---------------------------------------------------------------------------=
----------------
|     A1.85  | Terminal supports keypad                 | C002      |
---------------------------------------------------------------------------=
----------------

C002 =3D If feature is implemented according to Rel-8 or later then O, else=
 M

In other words, the events are optional if we are following at least the =

release 8 for the display and keypad capabilities.
So far, I don't see what is the specificity of the release 8 regarding =

those capabilities.

But for previous release, I'm afraid, those events are mandatory as =

stated by Lasse.

Regards,

Philippe.

--===============8250563148108776568==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMDEgVHJhbnNpdGlvbmFs
Ly9FTiI+CjxodG1sPgogIDxoZWFkPgogICAgPG1ldGEgY29udGVudD0idGV4dC9odG1sOyBjaGFy
c2V0PUlTTy04ODU5LTEiCiAgICAgIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSI+CiAgICA8dGl0
bGU+PC90aXRsZT4KICA8L2hlYWQ+CiAgPGJvZHkgYmdjb2xvcj0iI2ZmZmZmZiIgdGV4dD0iIzAw
MDAwMCI+CiAgICBPbiAwMS8yNC8yMDExIDExOjQ5IEFNLCBNYXJjZWwgSG9sdG1hbm4gd3JvdGU6
CiAgICA8YmxvY2txdW90ZSBjaXRlPSJtaWQ6MTI5NTg2NjE0NC4yNjc2LjE1LmNhbWVsQGFlb25m
bHV4IiB0eXBlPSJjaXRlIj4KICAgICAgPHByZSB3cmFwPSIiPkhpIExhc3NlLAoKPC9wcmU+CiAg
ICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPgogICAgICAgIDxibG9ja3F1b3RlIHR5cGU9ImNp
dGUiPgogICAgICAgICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+CiAgICAgICAgICAgIDxwcmUg
d3JhcD0iIj5JIGFtIGNoZWNraW5nIHdoYXQgaXMgdGhlIGxldmVsIG9mIFNBVC9TVEsgc3VwcG9y
dCBpbiBvZm9ubyBhbmQgaGF2ZSBhIGNvdXBsZSBvZiBxdWVzdGlvbnMuIFRoZSBjdXJyZW50IGlt
cGxlbWVudGF0aW9uIGNvbnRhaW5zIHN1cHBvcnQgZm9yIGJhc2ljIFNUSyBjb21tYW5kcywgbGlr
ZSBtZW51cywgaW5wdXRzLCBjYWxscywgc21zIGFuZCBzbyBvbi4gSW4gVE9ETywgdGhlcmUgaXMg
b25seSBSRUZSRVNIIGNvbW1hbmQgb24gdGhlIGxpc3QuCgpJcyB0aGVyZSBwbGFucyBvciBpZGVh
cyB0byBleHRlbmQgdGhlIHN1cHBvcnQgaW4gb0Zvbm8gQ29yZSB3aXRoIG1vcmUgY29tcGxleCBT
VEsgZmVhdHVyZXMgbGlrZSAoM0dQUCBUUyAzMS4xMTEpOgotIENhbGwgY29udHJvbCBieSBVU0lN
Ci0gTU8gU01TIENvbnRyb2wgYnkgVVNJTQo8L3ByZT4KICAgICAgICAgIDwvYmxvY2txdW90ZT4K
ICAgICAgICAgIDxwcmUgd3JhcD0iIj4KTGV0IHVzIHNldCBhc2lkZSB0aGUgdGhlIG1lcml0cyBv
ZiB0aGUgdXNlIGNhc2VzIGZvciB0aGVzZSBmZWF0dXJlcyBmb3IKdGhlIG1vbWVudCA7KSAgSW1w
bGVtZW50aW5nIENhbGwgY29udHJvbCBieSBVU0lNIGlzIGZhaXJseQpzdHJhaWdodGZvcndhcmQg
dG8gZG8gaW4gdGhlIGNvcmUuICBIb3dldmVyLCBubyBtb2RlbSBtYW51ZmFjdHVyZXIKY3VycmVu
dGx5IGFsbG93cyB1cyB0byBoYXZlIGZ1bGwgY29udHJvbCBvdmVyIHRoaXMgZmVhdHVyZS4gIEl0
IGlzCmltcGxlbWVudGVkIGluIHRoZSBmaXJtd2FyZSBhbmQgZXZlcnkgdmVuZG9yIGRvZXMgdGhp
cyBkaWZmZXJlbnRseS4gIFNvCmZvciBub3cgc3VwcG9ydCBvZiB0aGlzIGZlYXR1cmUgaXMgaW4g
dGhlIHJlYWxtIG9mIHRoZSBtb2RlbSBkcml2ZXIuCgo8L3ByZT4KICAgICAgICA8L2Jsb2NrcXVv
dGU+CiAgICAgICAgPHByZSB3cmFwPSIiPm9rYXksIHNvIGFzc3VtaW5nIHRoaXMgaXMgaG93IGl0
IGlzIGdvaW5nIHN0YXkuIEV2ZW4gbW9kZW0gaGFuZGxlcwp0aGVzZSwgb2Zvbm8gc2hvdWxkIGRl
bGl2ZXIgcG9zc2libGUgQWxwaGFJZCBTSU0gbWF5IGdpdmUgaW4gYSByZXNwb25zZQp0byBjYWxs
IGNvbnRyb2wgZW52ZWxvcGUuIEkgZGlkIG5vdCBzZWUgaWYgdGhpcyBpcyBpbXBsZW1lbnRlZC4g
T3IgaXMgaXQKZHJvcHBlZCBzaW5jZSBpdCBpcyBub3QgdGVzdGVkIGluIEdDRi4uCjwvcHJlPgog
ICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgIDxwcmUgd3JhcD0iIj4Kc2hvdyB1cyBtb2RlbSBoYXJk
d2FyZSB3aGVyZSB0aGlzIGlzIG5lZWRlZC4gQXQgc29tZSBwb2ludCB3ZSBqdXN0IGhhZAp0byBi
ZSByZWFsaXN0aWMgaGVyZSBpbiB3aGF0IGNhbiBiZSB0ZXN0ZWQgd2l0aCByZWFsIGhhcmR3YXJl
LiBBbmQgdGh1cwppcyByZWFsbHkgcmVxdWlyZWQgdG8gYmUgc3VwcG9ydGVkIGFuZCB3aGF0IG1h
a2VzIHNlbnNlIGluIGEgc21hcnRwaG9uZQplbnZpcm9ubWVudC4KCjwvcHJlPgogICAgICA8Ymxv
Y2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAg
ICAgICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPgogICAgICAgICAgICA8cHJlIHdyYXA9IiI+
LSBCSVAgKEJlYXJlciBpbmRlcGVuZGVudCBwcm90b2NvbCksIGluY2x1ZGluZyBjb21tYW5kcyBs
aWtlIE9QRU4gQ0hBTk5FTCwgQ0xPU0UgQ0hBTk5FTCwgU0VORC9SRUNFSVZFIERBVEEKPC9wcmU+
CiAgICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgPC9ibG9ja3F1b3RlPgogICAgICAgIDxw
cmUgd3JhcD0iIj5CSVAgaXMgb24gbWFueSBvcGVyYXRvcnMnIHdpc2ggbGlzdCBvZiBzdXBwb3J0
ZWQgU0FUIGZlYXR1cmVzLiBFdmVuIGl0CmlzIG9wdGlvbmFsIGluIDNHUFAsIHNvbWUgbWFya2V0
IGFyZWFzIHdpbGwgcHJvYmFibHkgcmVxdWlyZSBCSVAuIEkKZG9uJ3QgaGF2ZSBhbiBleGFtcGxl
IHRvIGdpdmUgcmlnaHQgbm93Lgo8L3ByZT4KICAgICAgPC9ibG9ja3F1b3RlPgogICAgICA8cHJl
IHdyYXA9IiI+CkkgdGhpbmsgdGhlIGltcG9ydGFudCBwaHJhc2UgaXMgIndpc2ggbGlzdCIuIFNv
IGZhciBub2JvZHkgY291bGQgcmVhbGx5CnNob3dlZCBtZSB0aGUgZXhhY3QgdXNlIGNhc2UgZm9y
IEJJUC4gSSBhbSBhY3R1YWxseSByZWFsbHkgaW50ZXJlc3RlZCBpbgp1bmRlcnN0YW5kaW5nIHdo
YXQgdGhlIG9wZXJhdG9ycyB3YW5uYSB1c2UgaXQgZm9yLiBJIHByZWZlciB0byBoYXZlIGhhcmQK
ZmFjdHMgaGVyZSBhbmQgbm90IGp1c3QgIndpc2ggbGlzdCIgYW5kICJwcm9iYWJseSIuIElmIHRo
aXMgaXMgbm90IGEKcmVxdWlyZW1lbnQgZm9yIGNlcnRpZmljYXRpb24gYW5kIHRoZSBvcGVyYXRv
ciBpcyBub3QgYWN0dWFsbHkgdXNpbmcKc3VjaCBhIGZlYXR1cmUgYXQgYWxsLCB0aGVuIHdoeSBi
b3RoZXIuIEZlZWwgZnJlZSB0byBjb252aW5jZSBtZQpvdGhlcndpc2UgaGVyZS4KCldoaWxlIHdl
IGNhbiBjZXJ0YWlubHkgbG9vayBpbnRvIHN1cHBvcnRpbmcgQklQIGF0IHNvbWUgcG9pbnQsIGJ1
dCBmcm9tCndoZXJlIEkgYW0gc3RhbmRpbmcgaXQgaXMgcHJldHR5IGNsZWFyOyBmaXJzdCBnZXQg
YWxsIG1hbmRhdG9yeSBTVEsKZmVhdHVyZXMgc29ydGVkIG91dCwgYmVmb3JlIHRyeWluZyB0byB3
b3JrIG9uIG9wdGlvbmFsIG9uZXMuCgo8L3ByZT4KICAgICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0
ZSI+CiAgICAgICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+CiAgICAgICAgICA8YmxvY2txdW90
ZSB0eXBlPSJjaXRlIj4KICAgICAgICAgICAgPHByZSB3cmFwPSIiPi0gRXh0ZW5kIHN1cHBvcnQg
aW4gUFJPVklERSBMT0NBTCBJTkZPCjwvcHJlPgogICAgICAgICAgPC9ibG9ja3F1b3RlPgogICAg
ICAgICAgPHByZSB3cmFwPSIiPgpXaGF0IHN1cHBvcnQgYXJlIHlvdSBsb29raW5nIGZvcj8gIE1v
c3Qgb2YgdGhlIGluZm9ybWF0aW9uIHRoYXQgaXMgYXNrZWQKYnkgcHJvdmlkZSBsb2NhbCBpbmZv
IGlzIGltcGxlbWVudGVkIGluIHRoZSBtb2RlbSBmaXJtd2FyZS4gIFdlIGhhdmUKb25seSBpbmNs
dWRlZCBzdXBwb3J0IGZvciBpdGVtcyB3aGljaCBhcmUgbm90IGNvdmVyZWQgYnkgdGhlIGZpcm13
YXJlLgoKPC9wcmU+CiAgICAgICAgPC9ibG9ja3F1b3RlPgogICAgICAgIDxwcmUgd3JhcD0iIj5J
ZiBhaW1pbmcgR0NGIGFwcHJvdmFsIHN1cHBvcnQgc2hvdWxkIGNvbnRhaW46IElNRUksIGxvY2F0
aW9uIGluZm8sCm5ldHdvcmsgbWVhc3VyZW1lbnRzJmFtcDtCQ0NIIGNoYW5uZWwgbGlzdCwgdGlt
aW5nIGFkdmFuY2UsIGFjY2Vzcwp0ZWNobm9sb2d5LCBJTUVJU1YsIEludGVyLWZyZXF1ZW5jeSBV
VFJBTiBtZWFzdXJlbWVudHMuIEFzIHlvdSBzYWlkCnRoZXNlIGFyZSBvZnRlbiBoYW5kbGVkIGJ5
IG1vZGVtLCBidXQgaXNuJ3QgcG9zc2libGUgdGhhdCBtb2RlbSBjYW4gYmUKY29uZmlndXJlZCBp
biBhIHdheSBpdCBsZWF2ZXMgdGhlIGZ1bGwgY29udHJvbCBvZiBTQVQgdG8gdGhlIGhvc3Q/CkFs
dGhvdWdoIGNlcnRhaW4gQVQgY29tbWFuZCBiYXNlZCBtb2RlbXMgd291bGQgcmVxdWlyZSBwcm9w
cmlldGFyeQpjb21tYW5kcyB0byBmZXRjaCBhbGwgdGhlIG5lZWRlZCBpbmZvcm1hdGlvbi4gU28g
aW4gdGhhdCBzZW5zZSBpdCBpcwptb3JlIGxvZ2ljYWwgZm9yIG1vZGVtIHRvIGhhbmRsZSB0aGVz
ZSBjb21tYW5kcyB3aGF0IHJlcXVpcmVzIGxvdyBsZXZlbAppbnRlcmZhY2VzLgo8L3ByZT4KICAg
ICAgPC9ibG9ja3F1b3RlPgogICAgICA8cHJlIHdyYXA9IiI+CldoYXQgd2UgaGF2ZSBzZWVuIHNv
IGZhciBpcyB0aGF0IGFsbCBvZiB0aGVzZSBhcmUgaGFuZGxlZCBieSB0aGUgbW9kZW0uCklmIHRo
ZSBtb2RlbSBoYXMgYWxsIGluZm9ybWF0aW9uIGF2YWlsYWJsZSwgdGhlbiB3aHkgYm90aGVyIHdh
a2luZyB1cAp0aGUgaG9zdCBDUFUgZm9yIHRoaXMuIEl0IGRvZXMgbWFrZSBhIGxvdCBvZiBzZW5z
ZSB0byBrZWVwIHRoZSBob3N0IENQVQphc2xlZXAgaWYgcG9zc2libGUuIEkgYW0gcHJldHR5IHBy
YWdtYXRpYyBoZXJlOyBpZiB3ZSBoYXZlIHRvIHN1cHBvcnQgYQptb2RlbSB0aGF0IGRvZXMgbm90
IGhhbmRsZSB0aGVzZSwgdGhlbiB3ZSBoYXZlIHRvIGRvIGl0LgoKU28gaWYgeW91IGhhdmUgbW9y
ZSBpbmZvcm1hdGlvbiBhYm91dCBvdGhlciBtb2RlbSB0eXBlcywgcGxlYXNlIGxldCB1cwprbm93
LiBBbmQgcGF0Y2hlcyBhcmUgYWx3YXlzIHdlbGNvbWUuCgo8L3ByZT4KICAgICAgPGJsb2NrcXVv
dGUgdHlwZT0iY2l0ZSI+CiAgICAgICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+CiAgICAgICAg
ICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICAgICAgPHByZSB3cmFwPSIiPi0gRVZF
TlQgRE9XTkxPQUQgLyBTRVQgVVAgRVZFTlQgTElTVAoKPC9wcmU+CiAgICAgICAgICA8L2Jsb2Nr
cXVvdGU+CiAgICAgICAgICA8cHJlIHdyYXA9IiI+CkFnYWluLCB3aGljaCBvbmVzIGFyZSB5b3Ug
bG9va2luZyBmb3I/ICBvRm9ubyBleHBsaWNpdGx5IGlnbm9yZXMgdGhlCmZvbGxvd2luZyB0d28g
ZXZlbnRzIGFzIHRoZXNlIG1ha2Ugbm8gc2Vuc2UgaW4gdGhlIHNtYXJ0cGhvbmUgY29udGV4dDoK
Ci0gSWRsZSBTY3JlZW4gQXZhaWxhYmxlCi0gVXNlciBBY3Rpdml0eQoKPC9wcmU+CiAgICAgICAg
PC9ibG9ja3F1b3RlPgogICAgICAgIDxwcmUgd3JhcD0iIj5JdCBsb29rcyBsaWtlICBJZGxlIFNj
cmVlbiBBdmFpbGFibGUgYW5kIFVzZXIgQWN0aXZpdHkgJmFtcDsgVXNlciBBY3Rpdml0eQphcmUg
bWFuZGF0b3J5IGZlYXR1cmVzIGluIDNHUFAgVFMgMzEuMTI0LCBjaGFwdGVyIDMuNCBBcHBsaWNh
YmlsaXR5CnRhYmxlLiBSZXN0IG9mIHRoZSBzdWItZmVhdHVyZXMgYXJlIGxpc3RlZCB0aGVyZS4g
CjwvcHJlPgogICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgIDxwcmUgd3JhcD0iIj4KRG9uJ3QgdGhl
eSBkZXBlbmQgb24gdGhlIFNUSyBwcm9maWxlIHRoYXQgeW91IGFyZSB1c2luZz8KCjwvcHJlPgog
ICAgPC9ibG9ja3F1b3RlPgogICAgPGJyPgogICAgPGZvbnQgc2l6ZT0iLTEiPkFwcGFyZW50bHks
IHRoZSBhbnN3ZXIgKHNoYWxsIHdlIHN1cHBvcnQgb3Igbm90CiAgICAgIHRob3NlIFVJIGV2ZW50
cyA/KSBzZWVtcyB0byBiZSBhbHNvIGxpbmtlZCB0byB3aGljaCByZWxlYXNlIHdlIGFyZQogICAg
ICBjbGFpbWluZyB0byBjb21wbHkgd2l0aCB0aGUgcHJvZHVjdC48YnI+CiAgICAgIDxicj4KICAg
ICAgSW5kZWVkLCBhY2NvcmRpbmcgdGhlIGNvbmZvcm1hbmNlIHNwZWNpZmljYXRpb24gPC9mb250
PgogICAgPHN0eWxlIHR5cGU9InRleHQvY3NzIj5wIHsgbWFyZ2luLWJvdHRvbTogMC4wOGluOyB9
PC9zdHlsZT48Zm9udAogICAgICBjb2xvcj0iIzAwMDAwMCI+PGZvbnQgc3R5bGU9ImZvbnQtc2l6
ZTogMjBwdDsiIHNpemU9IjUiPjxmb250CiAgICAgICAgICBzdHlsZT0iZm9udC1zaXplOiAzMnB0
OyIgc2l6ZT0iNyI+PHNwYW4gbGFuZz0iZW4tR0IiPjwvc3Bhbj48L2ZvbnQ+PC9mb250PjwvZm9u
dD4KICAgIDxmb250IHNpemU9Ii0xIj4zMS4xMjQsIHRoZSB0ZXN0cyByZWxhdGVkIHRvIHRoZSBl
dmVudHMgYXJlCiAgICAgIGRlc2NyaWJlZCBhcyBmb2xsb3dzOjwvZm9udD4KICAgIDxmb250IHNp
emU9Ii0xIj48YnI+CiAgICA8L2ZvbnQ+PGZvbnQgc2l6ZT0iLTEiPjxiPjxicj4KICAgICAgICBU
YWJsZSBCLjE6IEFwcGxpY2FiaWxpdHkgb2YgdGVzdHM8L2I+PC9mb250PgogICAgPGZvbnQgc2l6
ZT0iLTEiPjxicj4KICAgIDwvZm9udD48Zm9udCBzaXplPSItMSI+Ci0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tPC9mb250PgogICAgPGZvbnQgc2l6ZT0iLTEiPjxicj4KICAgICAg
fCAmbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyBJdGVtIGRlc2Ny
aXB0aW9uJm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB8Jm5ic3A7IFdoYXRldmVyIGlzCiAgICAgIHRoZSBy
ZWxlYXNlJm5ic3A7IHwmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAm
bmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7CiAg
ICAgIFByb2ZpbGUmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsgfDxicj4KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS08YnI+CiAgICAgIHwgPC9mb250Pjxmb250IHNpemU9Ii0xIiBjb2xvcj0iIzAwMDAwMCI+PGZv
bnQgc3R5bGU9ImZvbnQtc2l6ZToKICAgICAgICA5cHQ7Ij4yNy4yMi43LjU6IHVzZXIgYWN0aXZp
dHkgZXZlbnQ8L2ZvbnQ+PC9mb250Pjxmb250CiAgICAgIHNpemU9Ii0xIj4mbmJzcDsgJm5ic3A7
Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgfCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyA8L2ZvbnQ+PGZvbnQgc2l6ZT0iLTEiCiAg
ICAgIGNvbG9yPSIjMDAwMDAwIj48Zm9udCBzdHlsZT0iZm9udC1zaXplOiA5cHQ7Ij5DMTc4PC9m
b250PjwvZm9udD48Zm9udAogICAgICBzaXplPSItMSI+ICZuYnNwOyZuYnNwOyZuYnNwOyAmbmJz
cDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAm
bmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsmbmJzcDsgfCZuYnNwOyZuYnNwOyZuYnNwOyA8L2Zv
bnQ+PGZvbnQKICAgICAgc2l6ZT0iLTEiIGNvbG9yPSIjMDAwMDAwIj48Zm9udCBzdHlsZT0iZm9u
dC1zaXplOiA5cHQ7Ij5FLjEvMzggQU5ECiAgICAgICAgRS4xLzMzIEFORCBFLjEvMTExPC9mb250
PjwvZm9udD48Zm9udCBzaXplPSItMSI+Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZu
YnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7CiAgICAgICZuYnNwOyZu
YnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7IHw8YnI+Ci0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPgogICAgICB8IDwvZm9udD48Zm9udCBzaXplPSItMSIg
Y29sb3I9IiMwMDAwMDAiPjxmb250IHN0eWxlPSJmb250LXNpemU6CiAgICAgICAgOXB0OyI+Mjcu
MjIuNy42OiBpZGxlIHNjcmVlbiBhdmFpbGFibGUgZXZlbnQ8L2ZvbnQ+PC9mb250Pjxmb250CiAg
ICAgIHNpemU9Ii0xIj4mbmJzcDsmbmJzcDsmbmJzcDsgfCZuYnNwOyAmbmJzcDsmbmJzcDsgPC9m
b250Pjxmb250IHNpemU9Ii0xIiBjb2xvcj0iIzAwMDAwMCI+PGZvbnQKICAgICAgICBzdHlsZT0i
Zm9udC1zaXplOiA5cHQ7Ij5DMTc3IEFORCBDMTc4PC9mb250PjwvZm9udD48Zm9udAogICAgICBz
aXplPSItMSI+ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7IHwmbmJz
cDsmbmJzcDsmbmJzcDsgPC9mb250Pjxmb250IHNpemU9Ii0xIgogICAgICBjb2xvcj0iIzAwMDAw
MCI+PGZvbnQgc3R5bGU9ImZvbnQtc2l6ZTogOXB0OyI+RS4xLzM5IEFORCBFLjEvMzMKICAgICAg
ICBBTkQgRS4xLzExMCBBTkQgRS4xLzExMTwvZm9udD48L2ZvbnQ+PGZvbnQgc2l6ZT0iLTEiPiZu
YnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgfDxicj4KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tPGJyPgogICAgPC9mb250PgogICAgPGZvbnQgc2l6ZT0iLTEiIGNvbG9yPSIjMDAw
MDAwIj48Zm9udCBzdHlsZT0iZm9udC1zaXplOiA5cHQ7Ij5DMTc3ID0KICAgICAgPC9mb250Pjwv
Zm9udD48Zm9udCBzaXplPSItMSIgY29sb3I9IiMwMDAwMDAiPjxmb250CiAgICAgICAgc3R5bGU9
ImZvbnQtc2l6ZTogOXB0OyI+SUYgQS4xLzg0IFRIRU4gTSBFTFNFIE4vQTwvZm9udD48L2ZvbnQ+
PGZvbnQKICAgICAgc2l6ZT0iLTEiPjxicj4KICAgIDwvZm9udD4KICAgIDxmb250IHNpemU9Ii0x
IiBjb2xvcj0iIzAwMDAwMCI+PGZvbnQgc3R5bGU9ImZvbnQtc2l6ZTogOXB0OyI+QzE3OCA9CiAg
ICAgIDwvZm9udD48L2ZvbnQ+PGZvbnQgc2l6ZT0iLTEiIGNvbG9yPSIjMDAwMDAwIj48Zm9udAog
ICAgICAgIHN0eWxlPSJmb250LXNpemU6IDlwdDsiPklGIEEuMS84NSBUSEVOIE0gRUxTRSBOL0E8
L2ZvbnQ+PC9mb250Pjxmb250CiAgICAgIHNpemU9Ii0xIj48Yj48YnI+CiAgICAgICAgPGJyPgog
ICAgICAgIFRhYmxlIEEuMTogT3B0aW9uczwvYj48L2ZvbnQ+CiAgICA8Zm9udCBzaXplPSItMSI+
PGJyPgogICAgPC9mb250Pjxmb250IHNpemU9Ii0xIj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tPC9mb250PgogICAgPGZvbnQgc2l6ZT0iLTEiPjxicj4KICAgICAgfCZuYnNwOyBJ
dGVtJm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyB8ICZuYnNwOyZuYnNwOyBPcHRpb24m
bmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyAm
bmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsm
bmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsg
Jm5ic3A7ICZuYnNwOyZuYnNwOwogICAgICB8PC9mb250Pjxmb250IHNpemU9Ii0xIj4mbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsgc3RhdHVzICZuYnNwOyAmbmJzcDsmbmJzcDsgfDxicj4KICAgIDwv
Zm9udD48Zm9udCBzaXplPSItMSI+Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08
L2ZvbnQ+CiAgICA8Zm9udCBzaXplPSItMSI+PGJyPgogICAgICB8ICZuYnNwOyZuYnNwOyZuYnNw
OyBBMS44NCZuYnNwOyB8IDwvZm9udD48Zm9udCBzaXplPSItMSIgY29sb3I9IiMwMDAwMDAiPjxm
b250CiAgICAgICAgc3R5bGU9ImZvbnQtc2l6ZTogOXB0OyI+VGVybWluYWwgc3VwcG9ydHMgZGlz
cGxheSBjYXBhYmlsaXR5PC9mb250PjwvZm9udD48Zm9udAogICAgICBzaXplPSItMSI+Jm5ic3A7
IHwmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgPC9mb250Pjxmb250IHNpemU9Ii0xIiBj
b2xvcj0iIzAwMDAwMCI+PGZvbnQKICAgICAgICBzdHlsZT0iZm9udC1zaXplOiA5cHQ7Ij5DMDAy
PC9mb250PjwvZm9udD48Zm9udCBzaXplPSItMSI+Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZu
YnNwOwogICAgICB8PGJyPgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPgog
ICAgICB8ICZuYnNwOyZuYnNwOyZuYnNwOyBBMS44NSZuYnNwOyB8IDwvZm9udD48Zm9udCBzaXpl
PSItMSIgY29sb3I9IiMwMDAwMDAiPjxmb250CiAgICAgICAgc3R5bGU9ImZvbnQtc2l6ZTogOXB0
OyI+VGVybWluYWwgc3VwcG9ydHMga2V5cGFkPC9mb250PjwvZm9udD48Zm9udAogICAgICBzaXpl
PSItMSI+Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgJm5ic3A7ICZuYnNwOyB8Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IDwvZm9udD48Zm9udCBzaXplPSItMSIKICAgICAgY29sb3I9IiMwMDAwMDAiPjxmb250
IHN0eWxlPSJmb250LXNpemU6IDlwdDsiPkMwMDI8L2ZvbnQ+PC9mb250Pjxmb250CiAgICAgIHNp
emU9Ii0xIj4gJm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyB8PGJyPgotLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tPGJyPgogICAgICA8YnI+CiAgICA8L2ZvbnQ+CiAgICA8Zm9udCBz
aXplPSItMSIgY29sb3I9IiMwMDAwMDAiPjxmb250IHN0eWxlPSJmb250LXNpemU6IDlwdDsiPkMw
MDIgPQogICAgICA8L2ZvbnQ+PC9mb250Pjxmb250IHNpemU9Ii0xIiBjb2xvcj0iIzAwMDAwMCI+
PGZvbnQKICAgICAgICBzdHlsZT0iZm9udC1zaXplOiA5cHQ7Ij5JZiBmZWF0dXJlIGlzIGltcGxl
bWVudGVkIGFjY29yZGluZyB0bwogICAgICAgIFJlbC04IG9yIGxhdGVyIHRoZW4gTywgZWxzZSBN
PC9mb250PjwvZm9udD48Zm9udCBzaXplPSItMSI+PGJyPgogICAgICA8YnI+CiAgICAgIEluIG90
aGVyIHdvcmRzLCB0aGUgZXZlbnRzIGFyZSBvcHRpb25hbCBpZiB3ZSBhcmUgZm9sbG93aW5nIGF0
CiAgICAgIGxlYXN0IHRoZSByZWxlYXNlIDggZm9yIHRoZSBkaXNwbGF5IGFuZCBrZXlwYWQgPC9m
b250Pjxmb250CiAgICAgIHNpemU9Ii0xIj5jYXBhYmlsaXRpZXM8L2ZvbnQ+PGZvbnQgc2l6ZT0i
LTEiPi48YnI+CiAgICAgIFNvIGZhciwgSSBkb24ndCBzZWUgd2hhdCBpcyB0aGUgc3BlY2lmaWNp
dHkgb2YgdGhlIHJlbGVhc2UgOAogICAgICByZWdhcmRpbmcgdGhvc2UgY2FwYWJpbGl0aWVzLiA8
YnI+CiAgICAgIDxicj4KICAgICAgQnV0IGZvciBwcmV2aW91cyByZWxlYXNlLCBJJ20gYWZyYWlk
LCB0aG9zZSBldmVudHMgYXJlIG1hbmRhdG9yeQogICAgICBhcyBzdGF0ZWQgYnkgTGFzc2UuPGJy
PgogICAgICA8YnI+CiAgICAgIFJlZ2FyZHMsPGJyPgogICAgICA8YnI+CiAgICAgIFBoaWxpcHBl
LjwvZm9udD48YnI+CiAgPC9ib2R5Pgo8L2h0bWw+Cg==

--===============8250563148108776568==--

