Content-Type: multipart/mixed; boundary="===============5197018181018350517=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/3] sim800: add sim800 support.
Date: Tue, 13 Nov 2018 16:04:50 +0100
Message-ID: <9649AA9E-7B31-433B-927D-B6DC319613A7@holtmann.org>
In-Reply-To: <20181113150009.GA4434@turing>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5197018181018350517==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Clement,

>>> ---
>>> plugins/sim900.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++++=
+------
>>> 1 file changed, 82 insertions(+), 9 deletions(-)
>>> =

>>> diff --git a/plugins/sim900.c b/plugins/sim900.c
>>> index a7728cd..bf7b9ec 100644
>>> --- a/plugins/sim900.c
>>> +++ b/plugins/sim900.c
>>> @@ -24,6 +24,7 @@
>>> #endif
>>> =

>>> #include <errno.h>
>>> +#include <string.h>
>>> #include <stdlib.h>
>>> #include <glib.h>
>>> #include <gatchat.h>
>>> @@ -60,13 +61,77 @@ static char *dlc_prefixes[NUM_DLC] =3D { "Voice: ",=
 "Net: ", "SMS: ",
>>> =

>>> static const char *none_prefix[] =3D { NULL };
>>> =

>>> +typedef enum type {
>>> +       SIM800,
>>> +       SIM900,
>>> +       SIM_UNKNOWN,
>> =

>> maybe SIMCOM_UNKNOWN ?
> =

> Yes, I do agree, updating patchset.

and no typedef please.

Regards

Marcel


--===============5197018181018350517==--

