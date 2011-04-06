Content-Type: multipart/mixed; boundary="===============7940843748646840759=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [RFC PATCH v3] gprs: add function to handle activated context
Date: Wed, 06 Apr 2011 16:00:02 +0300
Message-ID: <BANLkTikCNtgvi2kNWDQOTabkKmtcM7QUEQ@mail.gmail.com>
In-Reply-To: <4D9C329C.2000106@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7940843748646840759==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Arun,

2011/4/6 Arun Ravindran <ext-arun.1.ravindran@nokia.com>:
> According to this, the cid of user initiated context and network initiated
> context doesn't overlap.

The problem is, the initial EPS context is initiated by mobile, not by
the network. The mobile sends a piggybacked
PDN CONNECTIVITY REQUEST with the initial attach request in order to
initiate the initial EPS context.

-- =

Pekka.Pessi mail at nokia.com

--===============7940843748646840759==--

