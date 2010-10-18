Content-Type: multipart/mixed; boundary="===============5999460232618940301=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Call Barring and MMI Supplementary Service codes
Date: Mon, 18 Oct 2010 16:26:02 -0500
Message-ID: <4CBCBB6A.3060306@gmail.com>
In-Reply-To: <C681C76E0D5F1E4BB01DE79E0A80EEC702B20366@usrdes03.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5999460232618940301==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rajesh,

On 10/15/2010 04:03 PM, Rajesh.Nagaiah(a)elektrobit.com wrote:
>  =

> Hi Fred,
> =

>> As per the 3GPP 22.030 Annex C:
>> - the MMI Service Code "22" refers to "All sync services" telecommunicat=
ion service.
>> - the MMI Service Code "24" refers to "All data circuit sync" telecommun=
ication service.
>>
>> They are both linked to the same Basic Group Service 8.
>> So as per our understanding, this means the "All sync services" is equal=
 to "All data circuit sync". Is that everyone's
>> comprehension as well?
> =

> Yes & No. Previously (Before Rel99, Refer GSM 02.02 and GSM 02.30) we had=
 the the bearer services "All dedicated PAD access" (BSG Number 9, MMI 27) =
and "All dedicated packet access" (BSG Number 10, MMI 26). In this "All ded=
icated PAD access" is an asynchronous connection and "All dedicated packet =
access" is a synchronous connection.
> =

> So "All Sync Services" used to be =3D> "All data circuit sync" + "All ded=
icated packet access"
> Now that bearer service "All dedicated packet access" is not supported, "=
All Sync Services" =3D> only "All data circuit sync" =

> =

>> When we try to run Call Barring certification tests (particularly 31.8.3=
.1 from 3GPP 51.010), the spec requires us to =

>> activate the call barring with the MMI code "22".
>> We do it using org.ofono.SupplementaryServices.Initiate with the followi=
ng string "*33*1234*22#" (This is the activation =

>> of BAOC with password "1234" on All Sync Services), Ofono then sends to =
the modem the following AT command: AT+CLCK=3D"
>> AO",1,"1234",16
>>
>> According to the 3GPP 27.007 =C2=A77.4 (CLCK), 16 is "data circuit sync".
>> So modem will translate that into "all data circuit sync" in the REGISTE=
R message sent to the network simulator.
>> However according to 3GPP 51.010 31.8.3.1, only a REGISTER message conta=
ining "All synchronous services" is awaited. So =

>> conformance  scripts will consider the test as FAILED.
>> We noticed the test would be PASS only if CLCK classx parameter was 80 (=
instead of 16). 80 =3D 16 (data circuit sync) + 64 =

>> (dedicated packet access).
> =

> As the AT command specification 27.007 still has values for dedicated pac=
ket access (64) and dedicated PAD access (128),
> in the AT modem case for "All Sync Services" we have to translate to "All=
 data circuit sync" (16) + "All dedicated packet access" (64) not only to "=
All data circuit sync" (16), otherwise as you pointed out the corresponding=
 conformance test case will fail. Thats the reason the test case passes whe=
n you pass 80.
> =


My interpretation of 22.004 and 22.030 was that dedicated packet access
and dedicated PAD access were deprecated and no longer being used.  The
fact that they're still listed in 27.007 seems to be irrelevant.

One possibility is that the bearer services covered by dedicated packet
& dedicated pad access were lumped together with bearer services 20 and
30 from 3GPP 22.002.

>> Shouldn't we translate the "*33*1234*22#" MMI SS String into AT+CLCK=3D"=
AO",1,"1234",80 ?
> =

> From my understanding YES.

I actually am fine making this change, and it is quite trivial to boot.
 But before we do that, can we confirm that this is indeed mandated by
the specs, and not an error in the test cases.

What values are expected from MMI services 25, 24 and 26?

Regards,
-Denis

--===============5999460232618940301==--

