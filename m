Content-Type: multipart/mixed; boundary="===============7033683524617769444=="
MIME-Version: 1.0
From: nick83ola <nick83ola@gmail.com>
Subject: Expose MBPI api over d-bus
Date: Mon, 02 Mar 2020 10:52:44 +0000
Message-ID: <CABPh3UNsBS8YnW5kWhMHaGkjPN8WFHB7gkXvFtDW9kyMn_FgQQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7033683524617769444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dear Ofono developers,

I need to expose the mbpi information over d-bus and possibly
automatically create profiles based on the information provided in the
mobile provider information database.

Do you think the right way could be:
- add a d-bus interface to the mbpi.c plugin
- or extend the allowed apn plugin to query the mobile provider database?
- or something else?

Thanks
Nicola Lunghi
--===============7033683524617769444==--

