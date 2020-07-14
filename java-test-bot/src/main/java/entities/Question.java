package entities;

/**
 * @author Tatiana Savonik
 */
public class Question {

    private final int id;
    private final String text;
    private final int chapterId;
    private final String comment;

    public Question(int id, String text, int chapterId, String comment) {
        this.id = id;
        this.text = text;
        this.chapterId = chapterId;
        this.comment = comment;
    }

    public int getId() {
        return id;
    }

    public String getText() {
        return text;
    }

    public int getChapterId() {
        return chapterId;
    }

    public String getComment() {
        return comment;
    }
}
