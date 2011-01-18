Content-Type: multipart/mixed; boundary="===============8667699042470575873=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/5] netreg: Add CPHS CSP PLMN mode implementation
Date: Tue, 18 Jan 2011 12:51:57 -0600
Message-ID: <4D35E14D.9060404@gmail.com>
In-Reply-To: <AANLkTinjgScOv8sEkzWCsmoa1spQfPJpw+G9x5npPULc@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8667699042470575873==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

On 01/18/2011 12:44 PM, Aki Niemi wrote:
> Hi Marcel,
> =

> 2011/1/18 Marcel Holtmann <marcel@holtmann.org>:
>>> +     if (netreg->settings) {
>>> +             g_key_file_set_boolean(netreg->settings, SETTINGS_GROUP,
>>> +                                     "ForcedAuto", netreg->forced_auto=
);
>>> +             storage_sync(netreg->imsi, SETTINGS_STORE, netreg->settin=
gs);
>>> +     }
>>
>> why are we bothering to store this value? Would it not be better to
>> re-read when bringing up the modem?
> =

> We read the value always, yes, but storing the last known value rids
> us of a superfluous PropertyChanged signal in the case when last value
> of forced_auto was true, and after reading is still true. This is
> because forced_auto is by default set to false.

Do you mean across atom instantiations here?  If so there are plenty of
other attributes that get emitted in a similar fashion, so my vote is to
just emit the signal.  Or are you worried about something else?

Regards,
-Denis

--===============8667699042470575873==--

