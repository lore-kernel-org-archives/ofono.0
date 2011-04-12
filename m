Content-Type: multipart/mixed; boundary="===============3866160017522932292=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 10/20] doc: add PreferredMode property to modem
Date: Tue, 12 Apr 2011 09:02:38 -0500
Message-ID: <4DA45B7E.5010008@gmail.com>
In-Reply-To: <AA48DD8077D5D945A49BD1782C1140F1EBB21B@fioues08.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3866160017522932292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vijay,

>> I don't like that this is being exposed on the modem =

>> interface.  This really belongs on a separate atom.  Not all =

>> modems are going to be LTE enabled yet...
>>
> Preferred mode is modem property on which mode modem is going to
> operate.
> Currently we have restricted this to read only for below reasons.
> 1.No proper business case on why would user needs to play around this.
> Unless operator give privilege to user to configure the modem behavior.
> 2.Setting the preferred mode from user side would bring in new API for
> driver essentially. =

> =


So again, this property is simply not going onto the Modem interface.
It doesn't belong there since not all modems will be LTE enabled.  In
particular those pesky CDMA-only modems or 3G/2G GSM modems.  You really
need to put this on a separate atom dealing with IMS.

And as mentioned before, I still see no actual use-case for this
property.  Until the usecase is presented, this property should be dropped.

Regards,
-Denis

--===============3866160017522932292==--

