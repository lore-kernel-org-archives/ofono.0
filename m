Content-Type: multipart/mixed; boundary="===============7135045179391231515=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v4 1/3] SIMCOM SIM900 module support
Date: Thu, 12 Jan 2012 12:52:50 +0100
Message-ID: <1326369170.6454.248.camel@aeonflux>
In-Reply-To: <CAGNC_aNi_DeKV5c3ns31f6r155xo_-JQoqBnRKy1HhrmkYCJSw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7135045179391231515==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Renat,

> >>>>> +  /* For obtain correct sms service number */
> >>>>> +  g_at_chat_send(data->modem, "AT+CSCS=3D\"GSM\"", NULL,
> >>>>> +                  NULL, NULL, NULL);
> >>>>
> >>>> you might better introduce a OFONO_VENDOR_SIM900 quirk and use that =
in
> >>>> the SMS atom driver. The phonebook support will also end up overwrit=
ing
> >>>> this one later on. So I am not even sure this works reliable this wa=
y.
> >>>> Might be just pure luck with the order of the atom.
> >>>>
> >>>
> >>> Actually this is fine assuming the modem does not support UTF-8
> >>> character set.  The builtin assumption for most atoms is that CSCS is
> >>> set to something sane before they're initialized.  The phonebook driv=
er
> >>> will temporarily switch to UCS2 for the duration of the phonebook read
> >>> and restore the previous setting.
> >>
> >> we did a vendor quirk for this for USSD of Qualcomm based modems. Maybe
> >> we should then also move that into the modem plugins.
> >>
> >
> > Yes, I think that would be cleaner.  I'll take care of it.
> >

> How I understand, it is correct that I call CSCS command from
> sim900_enable? Or I must move it in another stage?

Denis and I pushed some patches to call AT+CSCS in the plugins. I think
the only thing you need to consider is doing after you are sure a SIM
card is present.

> Can I add OFONO_VENDOR_SIM900 in drivers/atmodem/vendor.h for use it
> instead OFONO_VENDOR_NOKIA in ofono_netreg_create?

Yes. Just send a separate patch adding the vendor quirk.

Regards

Marcel



--===============7135045179391231515==--

