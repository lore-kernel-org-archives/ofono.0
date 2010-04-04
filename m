Content-Type: multipart/mixed; boundary="===============2101432382280978005=="
MIME-Version: 1.0
From: Dario <djdas@djdas.net>
Subject: SQLite History plugin DB Schema
Date: Sun, 04 Apr 2010 17:54:38 +0200
Message-ID: <4BB8B63E.80406@djdas.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2101432382280978005==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,
as promised last week (sorry for the delay) following is the DB schema =

for the SQLite history plug-in, there are 3 tables: one for the infos =

about calls, one for incoming SMSes and one for outgoing ones. I wrote =

some comments in the scripts to clarify fields informations, please feel =

free to comment/correct if you think something could be wrong or better =

handled.
I'm also finishing a first plug-in version, I'll send the patches to the =

current git revision as soon as possible.
Thank you in advance, happy Easter :)
Dario

------------- cut here ------------- cut here ------------- cut here =

------------- cut here -------------

CREATE TABLE "ofono_history_calls" (
    "ohc_modem_path" TEXT, -- Modem path string i.e. "/modem0"
    "ohc_type" INTEGER, -- Call type ( 0 =3D Call ended, 1 =3D Call missed )
    "ohc_direction" INTEGER, -- Call direction ( 0 =3D Mobile Originated, =

1 =3D Mobile Terminated )
    "ohc_phone_number" TEXT, -- Other party phone number
    "ohc_start_time" TEXT, -- Starting date/time
    "ohc_end_time" TEXT -- Ending date/time
);
CREATE TABLE "ofono_history_incoming_messages" (
    "ohim_modem_path" TEXT, -- Modem path string i.e. "/modem0"
    "ohim_msg_id" INTEGER, -- oFono unique message id number
    "ohim_sender" TEXT, -- Sender phone number
    "ohim_text" TEXT, -- Message text
    "ohim_local_date" TEXT, -- Local sent date/time
    "ohim_remote_date" TEXT -- Remote sent date/time
);
CREATE TABLE "ofono_history_outgoing_messages" (
    "ohom_modem_path" TEXT, -- Modem path string i.e. "/modem0"
    "ohom_msg_id" INTEGER, -- oFono unique message id number
    "ohom_recipient" TEXT, -- Recipient phone number
    "ohom_text" TEXT, -- Message text
    "ohom_creation_date" TEXT, -- Message creation date/time
    "ohom_send_status" INTEGER, -- Sending status ( 0 =3D Pending, 1 =3D =

Submitted, 2 =3D Failed )
    "ohom_status_update_date" TEXT -- Last row update date/time
);
CREATE UNIQUE INDEX "ohim_idx_msg_id" on ofono_history_incoming_messages =

(ohim_msg_id ASC);
CREATE UNIQUE INDEX "ohom_idx_msg_id" on ofono_history_outgoing_messages =

(ohom_msg_id ASC);

------------- cut here ------------- cut here ------------- cut here =

------------- cut here -------------


--===============2101432382280978005==--

