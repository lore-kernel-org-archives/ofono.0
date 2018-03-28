Content-Type: multipart/mixed; boundary="===============1592306059091822531=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 10/30] qmi: remove unused qmi_service_cancel
Date: Wed, 28 Mar 2018 16:07:10 -0500
Message-ID: <19fec226-3ce1-7612-0cc7-01c6210df94b@gmail.com>
In-Reply-To: <20180328190016.28509-11-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1592306059091822531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/28/2018 01:59 PM, Jonas Bonn wrote:
> The function is not used anywhere in the codebase.

I think it would be fundamentally wrong to drop this.  Similar =

capability is used in other drivers all the time.

Regards,
-Denis

--===============1592306059091822531==--

