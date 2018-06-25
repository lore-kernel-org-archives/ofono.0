Content-Type: multipart/mixed; boundary="===============5899174195399484660=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/12] include: Expose voicecall related enums to plugins
Date: Mon, 25 Jun 2018 12:46:45 -0500
Message-ID: <1f9329e1-dd64-f43f-612d-32a62cef595c@gmail.com>
In-Reply-To: <74cffa7f-43f4-bdbc-2be3-066533b99d09@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5899174195399484660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

> Also, enum ofono_clir_option (which seems to be a 27.007 thing too) is =

> defined in include/types.h which is a bit inconsistent.

It really isn't.  The CLIR option is a bit special because it uses a =

letter 'I', 'i' or default.  I suppose we could have used a 'char' type =

for this, but it isn't an actual number defined in 27.007.

Regards,
-Denis

--===============5899174195399484660==--

