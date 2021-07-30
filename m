Content-Type: multipart/mixed; boundary="===============3308299438125017987=="
MIME-Version: 1.0
From: ajlennon@dynamicdevices.co.uk
Subject: Re: Documentation on when to free structures in/after callbacks
Date: Fri, 30 Jul 2021 14:24:48 +0000
Message-ID: <20210730142448.2797.36519@ml01.vlan13.01.org>
In-Reply-To: <531dafbe-1ab1-2a89-576d-6586f5d42c1b@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3308299438125017987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks Denis that helps. I see I need to learn a bit and get my head around=
 this.

For example I find this really confusing:

  cbd =3D req_cb_data_ref(cbd);
        if (g_at_chat_send(nmd->chat, "AT+CESQ", cesq_prefix,
                                cesq_cb, cbd, req_cb_data_unref) =3D=3D 0) {
                CALLBACK_WITH_FAILURE(cbd->cb, cbd->data);
                req_cb_data_unref(cbd);
        }

This does some kind of allocation - ok
This makes the call - ok fine
Provides the unref function into the call - ok so far

But then I'm thinking if the call _succeeds_ our unref gets called?
But if our call _fails_ then we have to do the unref ourselves?
--===============3308299438125017987==--

