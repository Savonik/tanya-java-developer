package entities;

/**
 * @author Tatiana Savonik
 */
public class Answer {

    private final String letter;
    private final String answer;
    private final int questionId;
    private final boolean valid;

    public Answer(String letter, String answer, int questionId, boolean valid) {
        this.letter = letter;
        this.answer = answer;
        this.questionId = questionId;
        this.valid = valid;
    }

    public String getLetter() {
        return letter;
    }

    public String getAnswer() {
        return answer;
    }

    public int getQuestionId() {
        return questionId;
    }

    public boolean isValid() {
        return valid;
    }
}
