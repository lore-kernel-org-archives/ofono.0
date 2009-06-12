Content-Type: multipart/mixed; boundary="===============0693295709990879156=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: MNC/MCC as string?
Date: Fri, 12 Jun 2009 12:12:33 +0200
Message-ID: <1244801553.8688.0.camel@violet>
In-Reply-To: <599a229656e82fa12be4d354525d7fbc@localhost>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0693295709990879156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> Anyway, here it is. Please test; seems to work for me on my N95.

+static void extract_mcc_mnc(const char *str, char *mcc, char *mnc)
 {
-       int num =3D 0;
-       unsigned int i;
-
        /* Three digit country code */
-       for (i =3D 0; i < 3; i++)
-               num =3D num * 10 + (int)(str[i] - '0');
-
-       *mcc =3D num;
-
-       num =3D 0;
+       strncpy(mcc, str, sizeof(mcc));
+       mcc[3] =3D '\0';

maybe I am blind, but how is this suppose to work. The sizeof(mmc) is 1
byte.

Regards

Marcel



--===============0693295709990879156==--

