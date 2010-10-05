Content-Type: multipart/mixed; boundary="===============7174549661632274437=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC online/offline atoms PATCH 2/4] sms: watch modem state
Date: Tue, 05 Oct 2010 13:59:55 +0200
Message-ID: <1286279995.17473.81.camel@aeonflux>
In-Reply-To: <1286278512-3529-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7174549661632274437==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> Allow use of SMS atom in online and offline states.  The messages are
> queued but not sent in offline mode. Errors occurring when an SMS is
> being sent while transition from online to offline are handled
> gracefully.

do we really want this? How is this suppose to work from the user
experience. I think just failing SendMessage with a proper error is a
more clear indication.

I had a quick test with my iPhone and it warns me about being in offline
mode and then sending just fails. And I have to manually trigger of
sending the message again.

So I am bit concerned about blindly spooling messages when in offline
mode.

Regards

Marcel



--===============7174549661632274437==--

