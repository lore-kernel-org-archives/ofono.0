Content-Type: multipart/mixed; boundary="===============0798940230985074823=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: SIM Insertion Notification
Date: Sat, 14 Jul 2012 06:02:22 -0500
Message-ID: <500151BE.5010102@gmail.com>
In-Reply-To: <AC43737FA4508F468C9A8245BF95DAE652C7B08F9A@RIMAILMBX1.gtk.gtech.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0798940230985074823==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Brian,

On 07/14/2012 11:31 AM, Ruptash, Brian wrote:
> I'm running ofono 1.7, with a Cinterion PH8-P plugin I wrote and will sub=
mit once I've fully tested it.  One problem I have is I never receive notif=
ication of SIM insertion, i.e. the Present propertyChanged.  Looking at the=
 code it seems pretty obvious why, unless I'm (probably) missing something.
>
> All the plugins, including mine, do similar to the following:
>
>      static void ph8_pre_sim(struct ofono_modem *modem)
>      {
>          struct ph8_data *data =3D ofono_modem_get_data(modem);
>          struct ofono_sim *sim;
>
>          ofono_devinfo_create(modem, 0, "atmodem", data->app);
>          sim =3D ofono_sim_create(modem, OFONO_VENDOR_CINTERION_PH8,
>                      "atmodem", data->app);
>
>          if (sim&&  data->have_sim =3D=3D TRUE)
>              ofono_sim_inserted_notify(sim, TRUE);
>      }
>
> The call to ofono_sim_create() probes the atmodem driver, which ends with:
>
>      g_idle_add(at_sim_register, sim);
>
> So the subsequent call to ofono_sim_inserted_notify() will fail, as at_si=
m_register() is called later when it is scheduled.
>
> The logs bear this out, so I'm at a loss to understand how anyone receive=
s a SIM notification... What am I missing here?
>

Everything is working as it should, what exactly is the problem?  You =

can call ofono_sim_inserted_notify before the atom is registered, but =

that means the Present property will be 'True' when you perform the =

initial GetProperties call.

This is meant for devices which do not support SIM hot-swap (e.g. most =

USB devices and many earlier phones where the SIM is behind the battery).

Regards,
-Denis

--===============0798940230985074823==--

