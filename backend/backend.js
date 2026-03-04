const SPREADSHEET_ID = "PASTE_ID_KALIAN_DI_SINI";

function doGet(e) {
  const path = (e.parameter && e.parameter.path) ? e.parameter.path : "";

  if (path === "presence/status") {
    return handleGetStatus(e);
  }

  return sendError("Route not found");
}

function doPost(e) {
  const path = (e.parameter && e.parameter.path) ? e.parameter.path : "";
  const body = JSON.parse(e.postData.contents);

  if (path === "presence/qr/generate") {
    return handleGenerateQR(body);
  }

  if (path === "presence/checkin") {
    return handleCheckin(body);
  }

  return sendError("Route not found");
}

function sendSuccess(data) {
  return ContentService
    .createTextOutput(JSON.stringify({ ok: true, data }))
    .setMimeType(ContentService.MimeType.JSON);
}

function sendError(error) {
  return ContentService
    .createTextOutput(JSON.stringify({ ok: false, error }))
    .setMimeType(ContentService.MimeType.JSON);
}

function handleGenerateQR(body) {
  if (!body.course_id || !body.session_id) {
    return sendError("missing_field");
  }

  const token = "TKN-" + Utilities.getUuid().substring(0,6).toUpperCase();
  const now = new Date();
  const expires = new Date(now.getTime() + 120000);

  const sheet = SpreadsheetApp.openById(SPREADSHEET_ID).getSheetByName("tokens");

  sheet.appendRow([
    token,
    body.course_id,
    body.session_id,
    now.toISOString(),
    expires.toISOString(),
    false
  ]);

  return sendSuccess({
    qr_token: token,
    expires_at: expires.toISOString()
  });
}