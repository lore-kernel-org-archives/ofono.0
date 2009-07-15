Content-Type: multipart/mixed; boundary="===============9220331192446643903=="
MIME-Version: 1.0
From: Marko Saukko <marko.saukko@gmail.com>
Subject: Re: Problems with voice call.
Date: Wed, 15 Jul 2009 08:56:59 +0300
Message-ID: <4A5D6FAB.8090500@gmail.com>
In-Reply-To: <200907141034.19444.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9220331192446643903==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>
> I've seen this reported at least twice now.  Which means that my SMS supp=
ort
> detection in atmodem driver is probably not quite correct.  Would you be =
able
> to report at which point in the drivers/atmodem/sms.c initialization that=
 this
> fails?
>

With the Option iCON 225 USB modem the SMS error is sent in function
at_cmgf_query_cb() at line 795.

795                 return at_sms_not_supported(modem);

This is because the mode variable is always set to 0 at line 788
(while loop is executed only onces) and the supported stays at value FALSE:

788                 while (g_at_result_iter_next_number(&iter, &mode))
789                         if (mode =3D=3D 1)
790                                 supported =3D TRUE;



I also tested oFono with the Nokia E51 phone which if I have understood
correctly supports of sending SMS messages at least on Windows
with PC Suite software. The result is a bit different.

With E51 the SMS error is returned from function at_cpms_query_cb()
on line 764.

764                 return at_sms_not_supported(modem);

This is because it does not go inside the while loop starting at line 741,
and the me_supported and sm_supported stays FALSE:

740
741                         while (g_at_result_iter_next_string(&iter, &sto=
re)) {
742                                 if (!strcmp(store, "ME"))
743                                         me_supported[mem] =3D TRUE;
744                                 else if (!strcmp(store, "SM"))
745                                         sm_supported[mem] =3D TRUE;
746                         }
747


Regards,
Marko

--===============9220331192446643903==--

