Content-Type: multipart/mixed; boundary="===============4106708871374648417=="
MIME-Version: 1.0
From: Ruptash, Brian <Brian.Ruptash@GTECH.COM>
Subject: SIM Insertion Notification
Date: Sat, 14 Jul 2012 12:31:49 -0400
Message-ID: <AC43737FA4508F468C9A8245BF95DAE652C7B08F9A@RIMAILMBX1.gtk.gtech.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4106708871374648417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'm running ofono 1.7, with a Cinterion PH8-P plugin I wrote and will submi=
t once I've fully tested it.  One problem I have is I never receive notific=
ation of SIM insertion, i.e. the Present propertyChanged.  Looking at the c=
ode it seems pretty obvious why, unless I'm (probably) missing something.

All the plugins, including mine, do similar to the following:

    static void ph8_pre_sim(struct ofono_modem *modem)
    {
        struct ph8_data *data =3D ofono_modem_get_data(modem);
        struct ofono_sim *sim;

        ofono_devinfo_create(modem, 0, "atmodem", data->app);
        sim =3D ofono_sim_create(modem, OFONO_VENDOR_CINTERION_PH8,
                    "atmodem", data->app);

        if (sim && data->have_sim =3D=3D TRUE)
            ofono_sim_inserted_notify(sim, TRUE);
    }

The call to ofono_sim_create() probes the atmodem driver, which ends with:

    g_idle_add(at_sim_register, sim);

So the subsequent call to ofono_sim_inserted_notify() will fail, as at_sim_=
register() is called later when it is scheduled.

The logs bear this out, so I'm at a loss to understand how anyone receives =
a SIM notification... What am I missing here?

-- Brian

CONFIDENTIALITY NOTICE: The information contained in this email message is =
intended only for use of the intended recipient. If the reader of this mess=
age is not the intended recipient, you are hereby notified that any dissemi=
nation, distribution or copying of this communication is strictly prohibite=
d. If you have received this communication in error, please immediately del=
ete it from your system and notify the sender by replying to this email. =
=C2=A0Thank you.

--===============4106708871374648417==--

