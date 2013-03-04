Content-Type: multipart/mixed; boundary="===============6497901481822932512=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/8] sierra: Support CDMA modems
Date: Mon, 04 Mar 2013 17:03:37 -0600
Message-ID: <51352849.9080506@gmail.com>
In-Reply-To: <20130304164836.GI11149@alittletooquiet.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6497901481822932512==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Forest,

On 03/04/2013 10:48 AM, Forest Bond wrote:
> Hi Denis,
>
> On Sun, Dec 30, 2012 at 08:34:29PM -0600, Denis Kenzior wrote:
>>> -	ofono_netreg_create(modem, 0, "atmodem", data->modem);
>>> +	if (data->have_gsm =3D=3D TRUE) {
>>> +		ofono_netreg_create(modem, 0, "atmodem", data->modem);
>>> +	} else if (data->have_cdma =3D=3D TRUE) {
>>> +		/*
>>> +		 * Once we have CnS protocol support, we should be able to do
>>> +		 * netreg that way instead of using the same port for both.
>>> +		 */
>>> +		ofono_cdma_netreg_create(modem, 0, "sierramodem", data->modem);
>>> +		ofono_cdma_connman_create(modem, OFONO_VENDOR_SIERRA,
>>> +						"cdmamodem", data->modem);
>>> +	}
>>
>> Ah I see what you're doing now.  This is really not going to work
>> too well if you have just one AT port available...
>
> I'm looking to pick this series back up now.  I understand the implementa=
tion is
> not ideal, but it at least provides for basic connectivity until we have =
support
> for the CnS protocol.  Will you accept the full series if I address the o=
ther
> issues with the code that you mentioned?

If we accept something upstream we assume full responsibility for the =

code, and everything that entails, including future maintenance.  Thus =

we do not have a habit of accepting functionality that is inherently =

broken.  So unless you can convince me otherwise, my answer is: "I'd =

rather not" ;)

Regards,
-Denis

--===============6497901481822932512==--

