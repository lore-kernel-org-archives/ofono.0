Content-Type: multipart/mixed; boundary="===============6592030702679819382=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 3/9] cdma-voicecall: Add CDMA MO Call Support
Date: Mon, 20 Dec 2010 15:48:16 -0600
Message-ID: <4D0FCF20.5050806@gmail.com>
In-Reply-To: <4D0FCEF0.8000501@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6592030702679819382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dara,

>>> +
>>> +struct ofono_cdma_voicecall_manager;
>>
>> Please call this ofono_cdma_voicecall.
> This is actually our preference as well as there is no multicall in
> CDMA, just the single voicecall. To that end, does it not make sense to
> also rename the interface "Voicecall" rather than "VoiceCallManager"?

This comment was based mostly on the naming of the current gsm voicecall
atom (e.g. ofono_voicecall, not ofono_voicecall_manager)

For the interface name I suggest we stick to .cdma.VoiceCallManager for
now to be consistent with the GSM naming.  However, I'm open to changing
this one in the future.

Regards,
-Denis

--===============6592030702679819382==--

