Content-Type: multipart/mixed; boundary="===============0703459603573429216=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/6] sim: give access to the driver
Date: Thu, 15 Mar 2018 12:27:19 -0500
Message-ID: <a226a462-45dc-4ba6-db8d-7c9eefddc20b@gmail.com>
In-Reply-To: <1521118170-23722-6-git-send-email-gabriel.lucas@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0703459603573429216==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gabriel,

> +const struct ofono_sim_driver* ofono_sim_get_driver(struct ofono_sim *si=
m);
No, please don't do this.  The driver should just issue the relevant =

command directly.

Regards,
-Denis

--===============0703459603573429216==--

