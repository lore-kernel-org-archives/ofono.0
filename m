Content-Type: multipart/mixed; boundary="===============4323508633815132645=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [PATCH 3/3] gprs.c: add list contexts for emulator
Date: Tue, 22 Mar 2011 15:17:26 +0000
Message-ID: <A782C372B9527D44AB20BF45FEEBB14F75BFCC0E03@irsmsx503.ger.corp.intel.com>
In-Reply-To: <4D88BB8B.5030101@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4323508633815132645==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>> Thanks Denis for your feedback.
>> The idea behind this code is to propose the complete support of the
>> usual AT+CGDCONT in the emulator. I think the best solution might be to
>> stick on contexts exposed over DBus, but this could lead to problems
>> like : a context is delete throught the DBus interface... how to handle
>> this change in the AT emulator, and avoid the use of the deleted context=
 ?
>
>Personally I'm not convinced CGDCONT management is even a good idea.
>The typical usecase is for DUN clients to send a CGDCONT string, but
>this can simply be accepted and ignored (for instance).

We are not looking at DUN only, but to the 'global' AT Emulator, that will =
be used during GCF/PTCRB certification.
During certification, a lot of test require to set some GPRS context with s=
pecific parameters. And this cannot go 'directly' to the modem, without goi=
ng through AP, because the test would not be relevant, or worse will failed=
, due to disconnect between oFono and modem.

>Just overwriting oFono's context store is not a good idea anyway as you
>lose certain valuable information.  For instance whether this context is
>used for internet (and ConnMan should pay attention to it) or it is used
>for mms, etc.
>
>It is also possible for the dial up client to provide context details
>that are identical to a context already defined in oFono.  In which case
>those details should be used instead (for the reasons outlined in the
>previous paragraph)

So from my point of view, all context must be in sync, in oFono side and mo=
dem side.

Regards,

Bertrand.
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============4323508633815132645==--

