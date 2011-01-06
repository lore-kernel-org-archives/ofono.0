Content-Type: multipart/mixed; boundary="===============0390993708993488812=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 0/2] Add additional information for mandatory general result
Date: Thu, 06 Jan 2011 11:41:06 -0800
Message-ID: <1294342868-15945-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0390993708993488812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 As per the ETSI TS 102 223 specification section 8.12.2,

For the general result "terminal currently unable to process command",
it is mandatory for the terminal to provide additional information.
Defined values for additional information can be found in the same
section. Coding '00' shall be used by the terminal if none of the defined
values apply.

 Following set of patches, introduce a macro for adding the additional
information and changes done to existing code to make use of added macro.

Regards,
Jeevaka

Jeevaka Badrappan (2):
  stk: add additional info for terminal busy result
  stk: make use of ADD_ERROR_RESULT macro

 src/stk.c |  114 ++++++++++++++++++++++++++++++++++++---------------------=
----
 1 files changed, 67 insertions(+), 47 deletions(-)


--===============0390993708993488812==--

