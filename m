Content-Type: multipart/mixed; boundary="===============1130341523744847969=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] sim: add ofono_sim_ready_notify() support
Date: Thu, 26 Aug 2010 10:18:09 -0500
Message-ID: <4C7685B1.1000609@gmail.com>
In-Reply-To: <AANLkTimmnAENOKP+HLKwifKTeuBeZ=Jkk=JrdwWSdFww@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1130341523744847969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 08/26/2010 07:17 AM, Pekka Pessi wrote:
> Hi Kristen and all,
> =

> I've been toying PUKs and PIN2s and it seems to me that insted of
> ofono_sim_ready_notify() driver needs a method with which it can
> announce which PIN code SIM might need. If that is none, then we
> proceed bit like after ofono_sim_ready_notify() in Kristen's patch. If
> on the other hand user somehow gets his SIM PUKed, the driver can
> indicate that to core, and we can change the SIM state back to
> PRESENT.

Seems like these are two separate issues.  We need sim_ready_notify for
the driver to tell us it is safe to proceed with modem initialization.
calypso, hso send us unsolicited notifications when sim, phonebook and
sms bits are ready.  Huawei (if we're lucky) tells us that the sim is
ready.  MBM does not do anything unless PIN was required, in which case
it uses EPEE/EPEV.

We need a separate case for sim dead / sim puked.

> =

> More comments to Kristen below:
> =

> 2010/8/25 Kristen Carlson Accardi <kristen@linux.intel.com>:
>> +#define SIM_STATUS_READY               1
>> +#define SIM_STATUS_WAITING_FOR_READY   (1 << 1)
>> +
>>  struct sim_file_op {
>>        int id;
>>        gboolean cache;
>> @@ -78,6 +81,7 @@ struct ofono_sim {
>>        GSList *new_numbers;
>>        GSList *service_numbers;
>>        gboolean sdn_ready;
>> +       unsigned int status;
>>        enum ofono_sim_state state;
>>        enum ofono_sim_password_type pin_type;
>>        gboolean locked_pins[OFONO_SIM_PASSWORD_SIM_PUK]; /* Number of PI=
Ns */
>> @@ -686,15 +690,20 @@ static void sim_enter_pin_cb(const struct ofono_er=
ror *error, void *data)
>>  {
>>        struct ofono_sim *sim =3D data;
>>        DBusMessage *reply;
>> +       gboolean ok =3D (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR);
>>
>> -       if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
>> +       if (!ok)
>>                reply =3D __ofono_error_failed(sim->pending);
>>        else
>>                reply =3D dbus_message_new_method_return(sim->pending);
>>
>>        __ofono_dbus_pending_reply(&sim->pending, reply);
>>
>> -       sim_pin_check(sim);
>> +       if (ok && (sim->status & SIM_STATUS_READY)) {
>> +               sim->status &=3D ~SIM_STATUS_WAITING_FOR_READY;
>> +               sim_pin_check(sim);
>> +       } else
>> +               sim->status |=3D SIM_STATUS_WAITING_FOR_READY;
>>  }
> =

> This does not work if modem 1) does not implement pin check or pin
> query 2) does not get ready immediately. isimodem comes to mind.

Yes, see my comment above.  The sim_ready needs to work with modems that
inform us they're ready, even if there's no PIN enabled.

> =

> I'd guess you should set the bit sim->status |=3D SIM_STATUS_WAITING_FOR_=
READY
> from sim_efpl_read_cb.
> =

> Perhaps renaming the sim_pin_query() as ofono_sim_ready_notify() and
> check for the WAITING_FOR_READY bit there? You could also set another
> bit in ofono_sim_ready_notify, just prevent it from running
> sim_initialize_after_pin() twice.
> =


Regards,
-Denis

--===============1130341523744847969==--

