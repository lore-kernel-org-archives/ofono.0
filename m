Content-Type: multipart/mixed; boundary="===============8522571543815625167=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: Re: [PATCH 1/8] telit: notify sim inserted when sim ready
Date: Mon, 20 Aug 2012 16:34:45 +0200
Message-ID: <50324B05.1080807@hale.at>
In-Reply-To: <5028FFC6.2030807@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8522571543815625167==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 13/08/12 15:23, Denis Kenzior wrote:
> Hi Christopher,
>
> On 08/13/2012 08:16 AM, Christopher Vogl wrote:
>>
>>   static void switch_sim_state_status(struct ofono_modem *modem, int =

>> status)
>>   {
>>       struct telit_data *data =3D ofono_modem_get_data(modem);
>> @@ -238,16 +223,13 @@ static void switch_sim_state_status(struct =

>> ofono_modem *modem, int status)
>>           break;
>>       case 1:
>>           DBG("SIM inserted");
>> -        /* We need to sleep a bit */
>> -        data->sim_inserted_source =3D g_timeout_add_seconds(1,
>> -                            sim_inserted_timeout_cb,
>> -                            modem);
>>           break;
>>       case 2:
>>           DBG("SIM inserted and PIN unlocked");
>>           break;
>>       case 3:
>>           DBG("SIM inserted and ready");
>> +        ofono_sim_inserted_notify(data->sim, TRUE);
>>           break;
>>       }
>
> According to Telit documentation 1 is inserted, 2 is inserted and pin =

> unlocked, 3 is unlocked and phonebook ready.  How do you plan on =

> handling PIN-locked SIMs?  You can't run commands such as EnterPin =

> until the sim is at least inserted.
Yes you are perfectly right, I can't do it that way. Working with an =

unlocked PIN is not always a good idea.

>
> You might need to do the same thing as we did for e.g. IFX and STE. =

> notify sim insertion on #QSS: 1, and only return from CPIN once #QSS: =

> 3 has been sent.  See drivers/atmodem/sim.c at_epev_notify() or =

> at_xsim_notify() for an example.

This works fine in case the PIN is locked, but has the unpleasant side =

effect that I receive a timeout when calling the D-Bus method to enter =

the PIN because #QSS: 3 takes so long (e.g. 32 seconds from entering the =

PIN until a #QSS: 3).
If the PIN is unlocked I will never get to at_pin_send_cb(), where =

+XSIM, *EPEV or #QSS are registered, and ofono will step to post-sim =

phase (where sms and phonebook atoms are created) immediately without =

waiting for #QSS: 3.

Regards,
Christopher






--
Scanned by MailScanner.


--===============8522571543815625167==--

