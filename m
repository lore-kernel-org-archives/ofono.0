Content-Type: multipart/mixed; boundary="===============6414337451178017249=="
MIME-Version: 1.0
From: ajlennon@dynamicdevices.co.uk
Subject: Re: Documentation on when to free structures in/after callbacks
Date: Fri, 30 Jul 2021 13:21:30 +0000
Message-ID: <20210730132130.2797.52595@ml01.vlan13.01.org>
In-Reply-To: <29743791-1526-f181-d024-eb3f747f9f74@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6414337451178017249==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>I'm not sure what you mean? What exactly do you think needs freeing?

Strange. I am lookinga at the drivers and sometimes unref functions are pro=
vided into other functions and sometimes not

        if (g_at_chat_send(nmd->chat, "AT+QENG=3D\"servingcell\"", qeng_pre=
fix,
                                qeng_cb, cbd, req_cb_data_unref) =3D=3D 0) {


Then these CALLBACK_WITH_FAILURE and CALLBACK_WITH_SUCCESS calls sometimes =
seem to have free functions after them and sometimes not.

I guess I am not understanding then.... Will continue look at this. I just =
thought there might be sometime in docs about the flow.

Regards,
-Alex
--===============6414337451178017249==--

