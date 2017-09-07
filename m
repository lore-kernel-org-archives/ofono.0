Content-Type: multipart/mixed; boundary="===============0598782496373948153=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/5] qmi: implement RAT selection
Date: Thu, 07 Sep 2017 11:55:23 -0500
Message-ID: <af3f318e-abb9-061c-69f3-029df77b6270@gmail.com>
In-Reply-To: <20170907121136.13520-2-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0598782496373948153==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 09/07/2017 07:11 AM, Jonas Bonn wrote:
> The QMI radio-settings atom was just a skeleton and did not even implement
> the mandtory property TechnologyPreference.  As such, it probably should
> never even have been registered for the modem.  Nonetheless, this patch
> puts this mandatory property into place.
> =

> This is implemented via the 'Set System Selection' method by way of the
> 'mode' parameter.  This seems to best reflect the intention of the Ofono
> API and works as expected when tested with a Quectel EC21.
> =

> Some notes:
> i)  There is an alternative function called 'Set Technology Preference'
>      which provides similar functionality.  This 'technology preference'
>      is updated automatically when the 'system selection mode' is modified
>      so everything seems to be in order.
> ii) For the EC21, switching the underlying technology works seamlessly.
>      There are indications, however, that some modems _might_ require a
>      reset before changes take effect; that bridge will need to be crossed
>      if reached.
> ---
>   drivers/qmimodem/nas.h            |  11 ++++
>   drivers/qmimodem/radio-settings.c | 119 +++++++++++++++++++++++++++++++=
+++++++
>   2 files changed, 130 insertions(+)
> =


I squashed a couple of extraneous empty lines and applied this patch. =

Thanks!

Regards,
-Denis


--===============0598782496373948153==--

