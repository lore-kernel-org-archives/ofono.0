Content-Type: multipart/mixed; boundary="===============8877193717404530168=="
MIME-Version: 1.0
From: Miettinen Pasi <pasi.miettinen@ixonos.com>
Subject: VS: [RFC PATCH 5/6] Support for concatenated SMS status report.
Date: Mon, 07 Jun 2010 15:22:23 +0300
Message-ID: <EA8B5A37FEEFC048AF3F8170D2819913B8C1280A51@jklmail01.ixonos.local>
In-Reply-To: <201006041704.34509.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8877193717404530168==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
> Hi Pasi,
>
> > ---
> >  include/history.h |    2 +
> >  src/sms.c         |   67 ++++++++++++++++++++----
> >  src/smsutil.c     |  152
> >  +++++++++++++++++++++++++++++++++++++++++++++++++++++ src/smsutil.h
> |
> >   32 +++++++++++
|
> I suggest thinking about the data structure use some more.  In particular,
> using a list of struct mr_numbers is very inefficient.  Using a pair of b=
itmaps
> for mr numbers (which can only be 0..255) would be way more efficient and
> probably would make the code much easier to write.

I am not sure if I am quite getting what do you mean. Do you mean something
like:
struct mr_numbers {
        unsigned int mr1 : 8,
        unsigned int mr2 : 8,
        unsigned int mr3 : 8,
        unsigned int mr4 : 8
};
So there wouldn't be so much padding bits or what's your angle here?
If that is it, how to indicate the status of the mr (enum sms_status_report=
_result)?

Br,
Pasi

--===============8877193717404530168==--

