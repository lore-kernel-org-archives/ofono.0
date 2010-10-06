Content-Type: multipart/mixed; boundary="===============5601741255327436247=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: CDMA SMS Handling
Date: Wed, 06 Oct 2010 11:01:40 +0200
Message-ID: <1286355700.6145.26.camel@aeonflux>
In-Reply-To: <C681C76E0D5F1E4BB01DE79E0A80EEC702AC9A8D@usrdes03.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5601741255327436247==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rajesh.

> There was a discussion about the CDMA SMS handling and CDMA PDUs in
> the
> IRC channel couple of days before. I would like to highlight the
> differences between CDMA and GSM PDU and how we should proceed with
> this
> from my understanding. Let me know your opinion.

thanks for the details and yes, we knew that the PDU format is
different. I am currently happy to see PDUs on CDMA at all right now.
Previous talks revealed that CDMA hardware might just only expose text
mode for AT commands. And that is a nasty situation that is almost
impossible to support within oFono.

If you guys have example SMS PDUs for CDMA, please collect them and lets
write some unit tests for it. Getting a head start on CDMA can't hurt
even we still have some GSM details to sort out first.

Regards

Marcel



--===============5601741255327436247==--

